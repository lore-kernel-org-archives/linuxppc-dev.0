Return-Path: <galak@kernel.crashing.org>
Message-Id: <41365E63-56F5-4057-9F4A-BE986969466C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40805221627u4c4580bane16f3c3e23c8e9f5@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] Add the PC speaker only when requested so
Date: Thu, 22 May 2008 22:34:42 -0500
References: <1211496016-30311-1-git-send-email-Emilian.Medve@Freescale.com>
	<fa686aa40805221627u4c4580bane16f3c3e23c8e9f5@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 22, 2008, at 6:27 PM, Grant Likely wrote:

> On Thu, May 22, 2008 at 4:40 PM, Emil Medve <Emilian.Medve@freescale.com 
> > wrote:
>> This will cause this minor boot-time debugging error message to go  
>> away:
>>
>> [    1.316451] calling  add_pcspkr+0x0/0x84
>> [    1.316478] initcall add_pcspkr+0x0/0x84 returned -19 after 0  
>> msecs
>
> What situation are you hitting this in?  The code should only run if
> there is a "pnpPNP,100" compatible node in the device tree.

The code always runs, the -19 is from the fact that the code returns - 
ENODEV when it doesn't find the device in the tree.

I don't see any reason we should be ALWAYS be probing for a PC  
speaker.  Seems like a reasonable patch.

> Also, where is CONFIG_PCSPKR_PLATFORM defined?  I don't see it
> anywhere in powerpc code and only a reference to it in an x86
> Makefile.  As it stands, it looks like this patch unconditionally
> disables the pcspkr code.

Its defined in init/Kconfig.

>
- k
