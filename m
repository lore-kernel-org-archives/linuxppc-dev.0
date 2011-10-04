Return-Path: <akpm00@gmail.com>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 33DE2B6F64
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  4 Oct 2011 11:50:28 +1100 (EST)
Received: by yxk8 with SMTP id 8so4708071yxk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 03 Oct 2011 17:50:25 -0700 (PDT)
Date: Mon, 3 Oct 2011 17:50:22 -0700
From: Andrew Morton <akpm00@gmail.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH] memory hotplug: Correct page reservation checking
Message-Id: <20111003175022.50cbef7f.akpm00@gmail.com>
In-Reply-To: <4E8098B9.1080702@austin.ibm.com>
References: <4E8098B9.1080702@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Greg KH <gregkh@suse.de>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 26 Sep 2011 10:22:33 -0500
Nathan Fontenot <nfont@austin.ibm.com> wrote:

> The check to ensure that pages of recently added memory sections are correctly
> marked as reserved before trying to online the memory is broken.  The request
> to online the memory fails with the following:
> 
> kernel: section number XXX page number 256 not reserved, was it already online?
> 
> This updates the page reservation checking to check the pages of each memory
> section of the memory block being onlined individually.

Why was this only noticed now?  Is there something unusual about the
way in which you're using it, or has nobody ever used this code, or...?
