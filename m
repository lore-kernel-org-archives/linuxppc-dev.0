Message-ID: <3D3750BB.9070503@lvl7.com>
Date: Thu, 18 Jul 2002 19:35:23 -0400
From: Neil Horman <nhorman@lvl7.com>
MIME-Version: 1.0
To: Khai Trinh <kqtrinh@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: inter-driver communication
References: <20020717212758.16528.qmail@web11505.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm not sure if an interrupt is exactly what you want here.  If you want to
facilitate communication between drivers I think that tasklets do the job fairly
well.  All you really need to do is have the destination driver export a
tasklet_struct that the source driver can reference as an external variable.
Then if you want the source driver to signal the destination driver to do
something, all it needs to do is call schedule_tasklet on the exported structure.
Hope that helps
Neil

Khai Trinh wrote:

> Hi folks,
>
> Are there ways in the linux kernel that allows
> driver-driver communications (ie: one driver
> interrupts another driver in an embedded application)?
>
> I have a driver that handles one device. When it is
> interrupted, I would like then to interrupt the other
> driver to handle the interrupt request?
>
> Any suggestion is welcome and appreciated.
>
> Thanks,
> --Khai
>
>
>


--
/******************************************************************
*Neil Horman
*Software Engineer
*LVL7 Systems
*13000 Weston Pkwy.
*Cary, NC 27513
*(919)-865-2915
*nhorman@lvl7.com
*PGP keyID 0xB5E1020A
*http://www.keyserver.net/en
*******************************************************************/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
