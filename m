Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id 35210DDEDE
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jun 2008 16:20:45 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so2087865ywh.39
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jun 2008 23:20:39 -0700 (PDT)
Message-ID: <fa686aa40806112320n4cfb667exb07eb364691c9d60@mail.gmail.com>
Date: Thu, 12 Jun 2008 00:20:39 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] Added support for PRTLVT based boards (MPC5121)
In-Reply-To: <48501248.8010104@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200806111143.08905.david.jander@protonic.nl>
	<48501248.8010104@freescale.com>
Cc: David Jander <david.jander@protonic.nl>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jun 11, 2008 at 11:58 AM, Scott Wood <scottwood@freescale.com> wrote:
> David Jander wrote:
>> +config MPC5121_GENERIC
>> +       bool
>> +       default n
>> +
>>  config MPC5121_ADS
>>        bool "Freescale MPC5121E ADS"
>>        depends on PPC_MULTIPLATFORM && PPC32
>>        select DEFAULT_UIMAGE
>>        select PPC_MPC5121
>> +       select MPC5121_GENERIC
>>        help
>>          This option enables support for the MPC5121E ADS board.
>>        default n
>> +
>> +config PRTLVT
>> +       bool "Protonic LVT family of MPC5121 based boards"
>> +       depends on PPC_MULTIPLATFORM && PPC32
>> +       select DEFAULT_UIMAGE
>> +       select PPC_MPC5121
>> +       select MPC5121_GENERIC
>> +       help
>> +         This option enables support for the Protonic LVT family (ZANMCU
>> and VICVT2).
>> +       default n
>
> Can we leave out the "default n" lines?  They're no-ops.
>
> I don't think these configs should depend on an option (PPC_MULTIPLATFORM)
> that is described as "Generic desktop/server/laptop"...

PPC_MULTIPLATFORM may be described poorly, but it is the appropriate
option.  However, it should probably be that the whole 5121 support
Kconfig should depend on MULTIPLATFORM, not individual board ports.
That being said, David is just duplicating what was already done for
the ADS board, so I'm not going to harp on him to change it in this
patch.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
