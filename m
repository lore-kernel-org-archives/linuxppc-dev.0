Return-Path: <glikely@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.201])
	by ozlabs.org (Postfix) with ESMTP id 1677367DA3
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 24 Jul 2005 03:03:46 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id i25so646565wra
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Jul 2005 10:03:45 -0700 (PDT)
Message-ID: <528646bc05072310039fb536d@mail.gmail.com>
Date: Sat, 23 Jul 2005 13:03:45 -0400
From: Grant Likely <glikely@gmail.com>
To: Yasushi SHOJI <yashi@atmark-techno.com>
In-Reply-To: <87hdeuosmq.wl@mail2.atmark-techno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <87hdeuosmq.wl@mail2.atmark-techno.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: ppc_sys.c with platform device model or create opb bus?
Reply-To: Grant Likely <glikely@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 7/17/05, Yasushi SHOJI <yashi@atmark-techno.com> wrote:
> I feel that the ppc_sys_spec is for SoC, which doesn't dynamically
> change the peripherals it has.  otoh, fpga based platform can have
> arbitrary number of devices if you configured so.
>=20
> I usually implement a device with PLB or OPB.  for those bus, should I
> use platform device model or create new buses for each?
ppc_sys is just a convenient wrapper around the platform device model.
 You can safely ignore ppc_sys if your board setup code calls
platform_device_register() for all of your devices directly.

Besides, as ppc moves to the flattened device tree for initializing
the platform bus, the whole ppc_sys stuff will be going away and the
device tree parsing code will call platform_device_* directly.

Cheers,
g.
