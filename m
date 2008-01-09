Return-Path: <neko@genesi-usa.com>
Received: from hu-out-0506.google.com (hu-out-0506.google.com [72.14.214.239])
	by ozlabs.org (Postfix) with ESMTP id D1FCADE09F
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 02:31:02 +1100 (EST)
Received: by hu-out-0506.google.com with SMTP id 24so109674hud.9
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Jan 2008 07:31:00 -0800 (PST)
Message-ID: <4784E977.3090006@genesi-usa.com>
Date: Wed, 09 Jan 2008 15:34:15 +0000
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Sven Luther <sven@powerlinux.fr>
Subject: Re: add phy-handle property for fec_mpc52xx
References: <20080109140608.GA15673@aepfle.de>	<fa686aa40801090644q5d1aa117ka7e8f5aed34237bd@mail.gmail.com>	<20080109144910.GA4222@powerlinux.fr>	<fa686aa40801090650l38bea6a0l7a1ea2d81667f42e@mail.gmail.com>
	<20080109145850.GA4413@powerlinux.fr>
In-Reply-To: <20080109145850.GA4413@powerlinux.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'd also say that the sound driver isn't ready for production use and it
misuses the BestComm task for generic bidirectional buffer copies by
forcing it to 32-bit transfers (this obviously involves some software
upsampling at some point as nearly all common sound data is 16-bit,
also twice the bandwidth to achieve). The Freescale docs for this task
(and the one provided by the firmware, no doubt, is identical in
operation) clearly state that the transfer size is configurable, so
saying it only accepts 32-bit sample data is simply inefficient and
lazy.

Someone needs to sit down and look at these, after a year of simple
stagnation since Sylvain lost the time to maintain them. I don't think
it is at all a good idea to think "oh it has been in the wild for a
year and nobody maintains it so we will mainline it now". That's a
ridiculous development philosophy. And, since nobody seems to give a
shit, it will stay as bad as it is right now (a quick hack) whether
in the wild or mainlined..

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Sven Luther wrote:
> On Wed, Jan 09, 2008 at 07:50:14AM -0700, Grant Likely wrote:
>> On 1/9/08, Sven Luther <sven@powerlinux.fr> wrote:
>>> On Wed, Jan 09, 2008 at 07:44:58AM -0700, Grant Likely wrote:
>>>> Woo!  Thanks Olaf.  I was just about to sit down and write something
>>>> like this myself.  Looks good to me.  I'll pick this up (but I'm going
>>>> to move it to the fixup_device_tree_efika() function)
>>> Indeed, thanks, this makes the efika kernel again work out of the box.
>>> Would it be possible to merge this upstream asap ?
>> I'll see if paulus will pick it up for 2.6.24
> 
> Cool, this would mean the only thing missing the patchset i have been
> carrying is the sound driver. Do you see something else that has been
> added since then ? 
> 
> Friendly,
> 
> Sven Luther
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
