Message-ID: <3F16857B.7010706@imc-berlin.de>
Date: Thu, 17 Jul 2003 13:16:11 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Eli Brin <elib@rokonet.co.il>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 8xx SCC's as uart
References: <75DF04AC5ED4D511A9810090273CB4163F5DE5@rokonet-e.rokonet.co.il>
In-Reply-To: <75DF04AC5ED4D511A9810090273CB4163F5DE5@rokonet-e.rokonet.co.il>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Eli Brin wrote:
> Hello,
>
> I have noticed, in kernel 2.4.20, that SCC1 and SCC4 cannot be configured as
> uarts.
>
> Also, the configuration for RTS,CTS,DCD and DTR are missing.
>
> Comparing 8xx_io/uart.c file to the 2.4.4 version of uart.c shows that all
> the code to support the above has been removed, although both show driver
> 0.3.
>
> Our target will use all SCC's as uarts with hardware handshake. So I will
> need to put this back into uart.c and the config.in files.
>
> Is there a reason for this feature (SCC1 and SCC4 as uarts are part of the
> 8xx ability) being removed ?

They haven't been removed! This feature just never made it into the
official BitKeeper tree.

Have a look at linuxppc_2_4_devel in the DENX CVS. Especialy between
the labels LABEL_2003_03_11_2045 and LABEL_2003_03_11_2055!

BTW: Make sure you understood the "hardware handshake" done by the
MPC8xx! MPC8xx CTS/RTS have a different meaning than you might expect
when dealing with real UARTS! Basicly the only support flow control in
one direction! So a device can throttle the MPC. But the MPC can _not_
stop the device from sending more!

Hope this helps.

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
