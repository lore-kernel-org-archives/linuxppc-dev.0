Return-Path: <tmbinc@elitedvb.net>
Message-ID: <45EF2985.1020407@elitedvb.net>
Date: Wed, 07 Mar 2007 22:07:17 +0100
From: Felix Domke <tmbinc@elitedvb.net>
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [patch 5/7] xenon: add SATA support
References: <20070307180144.812594000@elitedvb.net>>
	<20070307180526.194853000@elitedvb.net>>
	<45EF285C.1090800@ru.mvista.com>
In-Reply-To: <45EF285C.1090800@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linuxppc-dev@ozlabs.org, Linux IDE <linux-ide@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sergei Shtylyov wrote:
> Felix Domke wrote:
>> This adds support for the HDD and DVD SATA controller on the xenon
>> southbridge.
>   Pleas post this to linux-ide@vger.kernel.org in the future.
I'll do.

>> It also disables ATA_TFLAG_POLLING in libata-core, which prevented the
>> DVD drive
>> from being detected. It needs to be investigated what exactly is wrong
>> here. 

>>      tf.protocol = ATA_PROT_PIO;
>> -    tf.flags |= ATA_TFLAG_POLLING; /* for polling presence detection */
>> +//    tf.flags |= ATA_TFLAG_POLLING; /* for polling presence
>> detection */
>    I doubt that this could *ever* get accepted.
It was not meant to be accepted, but to work around the problem which
was introduced in 2.6.19. I have far too less knowledge of the SATA
layer to understand why this flag exactly causes the detection of the
DVD-Drive fail.

As said, this needs to be investigated, and fixed (in the driver, of
course, not in the subsystem).

>> +static unsigned int get_scr_cfg_addr(unsigned int port_no, unsigned
>> int sc_reg, int device)
>> +{
>> +    unsigned int addr = SIS_SCR_BASE + (4 * sc_reg);
>> +
>    Why we need device and port_no arguments here?
As there is only one device/port per PCI device, the arguments should
probably be removed from this function, right.

>> +    if (sc_reg == SCR_ERROR) /* doesn't exist in PCI cfg space */
>> +        return 0; /* assume no error */
>    Since SCR_ERROR == 1, this check seems broken.
Why?


Felix
