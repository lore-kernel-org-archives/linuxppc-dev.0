Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3CADD870.4050200@control.auc.dk>
Date: Fri, 05 Apr 2002 19:01:36 +0200
From: Jon Fridriksson <jonff@control.auc.dk>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Cannot boot properly
References: <20020405144452.6FF7E11250@denx.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:

>Dear Jon,
>
>in message <3CADA82E.9000502@control.auc.dk> you wrote:
>
>>I connect my target to my PC through an ethernet and a serial port and
>>mount a NFS root file system. Here is where the probem arises with the
>>newer kernel. When i boot (with bootm command in ppcboot), the output on
>>my screen is all garbled where everything was ok before. The kernel is
>>still active on the target but does not respond throgh the serial port
>>anymore. (I use minicom to connect and boot parameters are set to 9600
>>baud in ppcboot).  Any ideas?? Does the newer kernel overide the baud
>>
>
>Check the output carefully, and compare against a working  system.  I
>bet, that most of the time every second character is missing, right?
>
Right!

>If this i the case, you have mis-configured the  serial  ports.  Make
>sure  to  enable  both SMC1 and SMC2 in the kernel configuration, and
>select the right one as console port. Also make sure that you  select
>CONFIG_ALTSMC2.
>

Done that and now it works !!

Thank you for your quick response


Regards
Jon F. Hjartar

>
>
>If you check with your ".config" file, the following  options  should
>be selected:
>
>	CONFIG_SMC1_UART=y
>	# CONFIG_CONS_SMC1 is not set
>	CONFIG_UART_MAXIDL_SMC1=1
>	CONFIG_SMC1_UART_RX_BDNUM=4
>	CONFIG_SMC1_UART_RX_BDSIZE=32
>	CONFIG_SMC1_UART_TX_BDNUM=4
>	CONFIG_SMC1_UART_TX_BDSIZE=32
>	CONFIG_SMC2_UART=y
>	CONFIG_ALTSMC2=y
>	CONFIG_CONS_SMC2=y
>	CONFIG_UART_MAXIDL_SMC2=1
>	CONFIG_SMC2_UART_RX_BDNUM=4
>	CONFIG_SMC2_UART_RX_BDSIZE=32
>	CONFIG_SMC2_UART_TX_BDNUM=4
>	CONFIG_SMC2_UART_TX_BDSIZE=32
>
>[This  system  uses  SMC2  as  console  port  -  the   settings   for
>CONFIG_CONS_SMC1 and CONFIG_CONS_SMC2 may be different on your box]
>
>>settings somehow? Is it necessary to upgrade to ppcboot-1.1.5 for the
>>newer kernel to boot??
>>
>
>This is not necessary (though recommended anyway).
>
>Wolfgang Denk
>

--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
