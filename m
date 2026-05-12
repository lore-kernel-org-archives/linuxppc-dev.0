Return-Path: <linuxppc-dev+bounces-20791-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C048CD4F24
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2026 15:32:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFLFQ5m8zz2xjQ;
	Wed, 13 May 2026 01:32:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=141.14.17.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778599962;
	cv=none; b=PkZQLq/HVjvpymsqG87YqPO2DYLFoELI4ngEm5LwCGlBJFtQzEgCP8jHGd5yiy60DqO683+tZxhWKgItpZ9svZqA8lIspMembnGenZjhHl5/XC9wDDduv71yVOvoGr4Z2Ie8Di7Fz3+sI4RP0uDPl1HZwb+Ga1w94K4E1VffM0kVBSDJDHub3qXpgsxdNPctfQ5/7kBBoxK9nxoQA/RPNKOW+iNLKLtSaeXRw/iI1LfPdjeX+RakRWvhdZEWWpd5dTgU2RJhrnLrEWb5m9k6Jjk1diWZpsdrBiswgiQczynydAvIUm5grXET/j7kwmY9/mC/bWeQGKE4HvlFbugPmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778599962; c=relaxed/relaxed;
	bh=wEeOdVzvWS+zMqZGy0g3J0Gc5+YCy2luOLA2Hx2yHBk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ABvaKtwHQJgpoXTKUxCCVWO6pxY8LB6dqN9y0AWe8YKNnrnqmdFp4XeMIDt3FEKonLq6QHNWZH2aEGk0y5bAW2vAsb7zIzTGgsYVbdw6sJloRPIMUwFFLbijpTVlZ9Ve5wUUpzit2Dy8IlxW8yu3XgrJtSi7mTpUS8vdqJjuyEj9HNIN8gOHE/jQAN3VcPHN+37G33ntv9JWfwDjzlrnpyBAXofEiiZ5sGFCZvGD9IMT0LEVJMWcgQzATqmLkK4PxLl7sGnYwOEDp0leEz52IihQU+gelaszHveuPZvIHj8UhumrIUHKwQkA9Ybu+Vs3BL7BehoKKYakoJLjC8OnIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass (client-ip=141.14.17.11; helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de; receiver=lists.ozlabs.org) smtp.mailfrom=molgen.mpg.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=molgen.mpg.de (client-ip=141.14.17.11; helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de; receiver=lists.ozlabs.org)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bit raw public key) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFLFN6QZ8z2xH9
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 01:32:38 +1000 (AEST)
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7401B4C2C37F08;
	Tue, 12 May 2026 17:32:10 +0200 (CEST)
Message-ID: <eff5ca07-26a9-40bd-8668-6e6ed69fe587@molgen.mpg.de>
Date: Tue, 12 May 2026 17:32:09 +0200
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: IBM Power S822LC: pci 0021:0d:00.0: xHCI HW did not halt within
 32000 usec status = 0x0
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <fb68e15d-b8f2-42ac-aa65-0d9fedcfcdbd@molgen.mpg.de>
 <20260506193037.6de9e355.michal.pecio@gmail.com>
 <69fa1c3f-3ea9-42cb-a49a-7da39f72806e@molgen.mpg.de>
 <20260512012006.66aeb0c5.michal.pecio@gmail.com>
 <6106b5b9-17d2-48be-8215-3320f3d1d261@molgen.mpg.de>
 <20260512102233.290d3665.michal.pecio@gmail.com>
Content-Language: en-US
In-Reply-To: <20260512102233.290d3665.michal.pecio@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[Cc: +Benjamin]

Dear Michal,


Thank you for your reply.

Am 12.05.26 um 10:22 schrieb Michal Pecio:
> On Tue, 12 May 2026 08:17:08 +0200, Paul Menzel wrote:>
>>> I honestly don't know what to do with this. I think I would start with
>>> looking whether xhci_shutdown() in the old kernel manages to halt it
>>> successfully or if it also fails, and what's the USBSTS there.
>>>
>>> It seems that you can get such information by enabling dynamic debug
>>>
>>>     echo 'module xhci_hcd +p' >/proc/dynamic_debug/control
>>>
>>> and capturing old kernel's log up to kexec() through a serial cable.
>>
>> Unfortunately, nothing is logged over the serial console (BMC SOL) after
>> running `sudo kexec -e` or `sudo systemctl reboot`. I just see:
>>
>>       [69530.180531343,5] OPAL: Switch to big-endian OS
>>       [69538.407292205,5] OPAL: Switch to little-endian OS
>>
>> Which is the OPAL firmware, so it might be involved? No idea, if it
>> touches the xHCI controller.
> 
> So some FW involvement is potentially possible.
> 
> BTW, another method of doing kexec is to setup a crash kernel and
> then trigger panic with /proc/sysrq-trigger.
> 
> This probably won't run xhci_shutdown(). Not sure about OPAL FW.
> Is the outcome any different?
Is the motivation to try to not get the OPAL message to rule out any 
involvement.

I have to check, how to set the crash kernel up.

>> But strangely no xHCI messages are there –  also after booting with
>> Petitboot and initialized xHCI controller? No idea, if it points to,
>> that during kexec or shutdown nothing is power off?
>>
>> With `sudo systemctl reboot` only the line below are logged:
>>
>>       [  121.811384] libvirt-guests.sh[3366]: Running guests on default URI:
>>       [  121.811988] libvirt-guests.sh[3376]: no running guests.
>>       [ … (systemd service stop notifications)]
>>       [  136.254846] systemd-shutdown[1]: Waiting for process: watch_ldconfig
>>       [  218.549684] reboot: Restarting system
>>       [69760.484679183,5] OPAL: Reboot request...
>>         3.55778|Ignoring boot flags, incorrect version 0x0
>>         3.59881|ISTEP  6. 3
> 
> Only "reboot: Restarting system" looks like it's kernel. Maybe you need
> to tweak loglevel before rebooting or kexecing? Try to get more kernel
> messages showing over serial during operation, then kexec.

I actually did set the log level by adding `debug` to the Linux kernel 
command line, and with

     $ echo 9 | sudo tee /proc/sysrq-trigger
     9

and it was confirmed:

     sysrq: Changing Loglevel
     sysrq: Loglevel set to 9

Unfortunately, no more messages.

As a further data point, adding `ppc_pci_reset_phbs` to the command line 
also gets xhci_hcd to initialize the TI xHCI host controller:

     $ lspci -nn -s 0021:0d:00.0
     0021:0d:00.0 USB controller [0c03]: Texas Instruments TUSB73x0 
SuperSpeed USB 3.0 xHCI Host Controller [104c:8241] (rev 02)


     [   14.050249]   Issue PHB reset ...
     […]
     [   19.339822] ehci_hcd: block sizes: qh 144 qtd 96 itd 192 sitd 96
     [   19.339919] ohci_hcd: block sizes: ed 112 td 96
     [   19.340538] xhci_hcd 0021:0d:00.0: xHCI Host Controller

No log `xHCI HW did not halt within 32000 usec status = 0x0` (or 0x10 
with the other patch). In `arch/powerpc/platforms/powernv/pci-ioda.c`, 
reading the comment in `pnv_pci_init_ioda_phb()` suggests, that PHB 
should be reset also in the kexec case:

         /*
          * If we're running in kdump kernel, the previous kernel never
          * shutdown PCI devices correctly. We already got IODA table
          * cleaned out. So we have to issue PHB reset to stop all PCI
          * transactions from previous kernel. The ppc_pci_reset_phbs
          * kernel parameter will force this reset too. Additionally,
          * if the IODA reset above failed then use a bigger hammer.
          * This can happen if we get a PHB fatal error in very early
          * boot.
          */
         if (is_kdump_kernel() || pci_reset_phbs || rc) {
                 pr_info("  Issue PHB reset ...\n");
                 pnv_eeh_phb_reset(hose, EEH_RESET_FUNDAMENTAL);
                 pnv_eeh_phb_reset(hose, EEH_RESET_DEACTIVATE);
         }

At least, I’d assume that kdump and kexec are similar, that both do not 
shut down PCI devices? (Commit 361f2a2a1536 (powrpc/powernv: Reset PHB 
in kdump kernel) from 2024 adds (some) the code above.)


Kind regards,

Paul

