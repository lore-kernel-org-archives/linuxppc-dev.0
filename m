Return-Path: <micha@neli.hopto.org>
Received: from edu-smtp-01.edutel.nl (edu-smtp-01.edutel.nl [88.159.1.175])
	by ozlabs.org (Postfix) with ESMTP id 1B6ADB70A9
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  8 Oct 2010 01:22:19 +1100 (EST)
Message-ID: <4CADD77A.90503@neli.hopto.org>
Date: Thu, 07 Oct 2010 16:21:46 +0200
From: Micha Nelissen <micha@neli.hopto.org>
MIME-Version: 1.0
To: Bastiaan Nijkamp <bastiaan.nijkamp@gmail.com>
Subject: Re: Serial RapidIO Maintaintance read causes lock up
References: <AANLkTikSaBR4vEikhGp0fsY3FnZCJQT2D-vw9=Kh4UHn@mail.gmail.com>
	<AANLkTimFgrRbRfsQqN9d9GOZhth072F9TKGXunaqJNVB@mail.gmail.com>
In-Reply-To: <AANLkTimFgrRbRfsQqN9d9GOZhth072F9TKGXunaqJNVB@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Bastian,

Bastiaan Nijkamp wrote:
> It seems i forgot to include the relevant TLB entries in U-Boot and the 
> Device Tree in the e-mail, so here they are:
> 
> The TLB entries in U-Boot:

The kernel maintains the TLB, you must not set those in U-boot. It might 
cause conflicts when the kernel chooses its virtual memory space. You 
should only configure LAWs in U-boot as the kernel does not do that. 
That's the physical address you pass in the DTB (which seems to work, 
reading your kernel log).

Do you access RapidIO space in U-boot also?

Do you have a logic analyser, then you can see whether the read is 
actually coming out.

Check whether the time-to-live, packet and link timeouts have been set 
to sane values to prevent deadlocks (especially time-to-live). At least 
then your kernel will crash instead of lock up.

Micha
