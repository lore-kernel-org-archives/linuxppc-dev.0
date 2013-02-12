Return-Path: <sr@denx.de>
Received: from mo6-p05-ob.rzone.de (mo6-p05-ob.rzone.de
 [IPv6:2a01:238:20a:202:5305::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 52B9F2C0308
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2013 22:04:12 +1100 (EST)
Message-ID: <511A219A.7080000@denx.de>
Date: Tue, 12 Feb 2013 12:03:54 +0100
From: Stefan Roese <sr@denx.de>
MIME-Version: 1.0
To: Bhushan Bharat-R65777 <R65777@freescale.com>
Subject: Re: [PATCH v2] net: fec_mpc52xx: Read MAC address from device-tree
References: <1360660088-27464-1-git-send-email-sr@denx.de>
 <6A3DF150A5B70D4F9B66A25E3F7C888D065A0271@039-SN2MPN1-023.039d.mgd.msft.net>
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D065A0271@039-SN2MPN1-023.039d.mgd.msft.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Anatolij Gustschin <agust@denx.de>, "David S. Miller" <davem@davemloft.net>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12.02.2013 11:56, Bhushan Bharat-R65777 wrote:
>> Until now, the MPC5200 FEC ethernet driver relied upon the bootloader
>> (U-Boot) to write the MAC address into the ethernet controller registers. The
>> Linux driver should not rely on such a thing. So lets read the MAC address from
>> the DT as it should be done here.
>>
>> The following priority is now used to read the MAC address:
>>
>> 1) First, try OF node MAC address, if not present or invalid, then:
>>
>> 2) Read from MAC address registers, if invalid, then:
> 
> Why we read from MAC registers if Linux should not rely on bootloader?

It was suggested by David. Backwards compatibility. Here Davids comment
to my original patch which removed this register reading completely:

"
I don't think this is a conservative enough change.

You have to keep the MAC register reading code around, as a backup
code path in case the OF device node lacks a MAC address
"

Thanks,
Stefan
