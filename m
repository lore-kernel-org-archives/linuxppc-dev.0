Return-Path: <dmitry.torokhov@gmail.com>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CF68AB712F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Feb 2011 06:33:35 +1100 (EST)
Received: by pzk34 with SMTP id 34so1442179pzk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 08 Feb 2011 11:33:32 -0800 (PST)
Date: Tue, 8 Feb 2011 11:33:21 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: [PATCH 1/2] misc: add CARMA DATA-FPGA Access Driver
Message-ID: <20110208193321.GA16527@core.coreip.homeip.net>
References: <1297121021-3522-1-git-send-email-iws@ovro.caltech.edu>
	<1297121021-3522-2-git-send-email-iws@ovro.caltech.edu>
	<20110208073309.GB906@core.coreip.homeip.net>
	<20110208172046.GB10125@ovro.caltech.edu>
	<20110208175028.GD4476@core.coreip.homeip.net>
	<20110208191143.GC10125@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110208191143.GC10125@ovro.caltech.edu>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 08, 2011 at 11:11:44AM -0800, Ira W. Snyder wrote:
> On Tue, Feb 08, 2011 at 09:50:29AM -0800, Dmitry Torokhov wrote:
> > On Tue, Feb 08, 2011 at 09:20:46AM -0800, Ira W. Snyder wrote:
> > 
> > > Go back and re-think my loop. This is a
> > > common idiom straight of out LDD3 pages 153-154.
> > > 
> > > You should note that it is only possible to exit the loop with the lock
> > > held AND !list_empty(used). The lock protects the used list, and
> > > therefore, there must be a buffer on the list.
> > 
> > No, because you are woken up while not holding the lock so another
> > reader is free to take it off the list.
> > 
> 
> Correct. But then I go around the loop and check list_empty() again
> before exiting the loop. The list MUST NOT be empty before the loop will
> terminate.

Yes, you are right, I competely missed the fact that we'd loop around
and check the condition again. I'll go grab another coffee now.

-- 
Dmitry
