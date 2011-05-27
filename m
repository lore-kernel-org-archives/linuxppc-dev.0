Return-Path: <Bruce_Leonard@selinc.com>
Received: from duster.selinc.com (duster.selinc.com [74.117.214.140])
	by ozlabs.org (Postfix) with ESMTP id 4AF7DB6FF8
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 28 May 2011 06:29:53 +1000 (EST)
In-Reply-To: <4DDFB49D.8010104@ovro.caltech.edu>
References: <OF1B4E92C8.698C0AE4-ON8825789D.00209684-8825789D.002206EF@selinc.com>
	<4DDFB49D.8010104@ovro.caltech.edu>
To: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
Subject: Re: MPC8308 bursting question
Message-ID: <OF8813D588.08896EF4-ON8825789D.007035CD-8825789D.00709882@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Fri, 27 May 2011 13:29:50 -0700
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi David,

> 
> Read my MPC8349EA UPM setup notes and see if you have used
> similar settings (I assume the local bus UPMs are similar):
> 

I found you paper interesting.  I didn't have a problem with my UPM 
settings, single beat reads and writes worked just fine, however it did 
tickle my memory and helped me find what was wrong.  Turns out that the 
person who was responsible for the BAx/ORx registers for this chip select 
had set the BI bit a long time ago, before we were contemplating doing 
what we're currently doing.  The code had been reviewed and signed off, so 
in my back brain I was thinking everything there was good.

When I read your paper, it mentioned the BI bit which got me to thinking. 
Sure enough, when I looked it was set.  Soon as I  cleared that bit, my 
burst transactions started working just fine.

Thanks for the help.

Bruce
