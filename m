Return-Path: <gerickson@nuovations.com>
Received: from relay03.pair.com (relay03.pair.com [209.68.5.17])
	by ozlabs.org (Postfix) with SMTP id AAB53DDF9B
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 09:48:01 +1000 (EST)
Date: Mon, 07 Jul 2008 16:47:53 -0700
Subject: Re: [PATCH] ibm_newemac: Add MII mode support to the EMAC RGMII
	bridge.
From: Grant Erickson <gerickson@nuovations.com>
To: <benh@kernel.crashing.org>
Message-ID: <C497F939.104DB%gerickson@nuovations.com>
In-Reply-To: <1215474042.8970.171.camel@pasglop>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org, sr@denx.de, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/7/08 4:40 PM, Benjamin Herrenschmidt wrote:
> On Mon, 2008-07-07 at 16:31 -0700, Grant Erickson wrote:
>>  #define RGMII_FER_GMII(idx)    (0x7 << ((idx) * 4))
>> +#define RGMII_FER_MII(idx)     (0x7 << ((idx) * 4))
> 
> Hrm... the setting of the register is exactly the same right ?
> 
> Do we -really- need that ?

Would you prefer?

    +#define RGMII_FER_MII(idx)     RGMII_FER_GMII(idx)

Having the "extra" mnemonic makes the code end up looking less like a typo
and more like a conscious decision: "Yes, we know MII and GMII are the same
setting, but we're being explicit about it."

-Grant
