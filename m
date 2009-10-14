Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f199.google.com (mail-yw0-f199.google.com
	[209.85.211.199]) by ozlabs.org (Postfix) with ESMTP id 346C7B7B7F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Oct 2009 06:33:16 +1100 (EST)
Received: by ywh37 with SMTP id 37so121359ywh.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 14 Oct 2009 12:33:14 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4AD62247.4020102@grandegger.com>
References: <20091014174224.29221.18830.stgit@angua>
	<4AD62247.4020102@grandegger.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 14 Oct 2009 13:32:54 -0600
Message-ID: <fa686aa40910141232nab95d4al13016d4dc4fbc6cf@mail.gmail.com>
Subject: Re: [PATCH v2] net/fec_mpc52xx: Fix kernel panic on FEC error
To: Wolfgang Grandegger <wg@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: John Bonesio <bones@secretlab.ca>, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 14, 2009 at 1:11 PM, Wolfgang Grandegger <wg@grandegger.com> wr=
ote:
> Grant Likely wrote:
>> From: John Bonesio <bones@secretlab.ca>
>>
>> The MDIO bus cannot be accessed at interrupt context, but on an FEC
>> error, the fec_mpc52xx driver reset function also tries to reset the
>> PHY. =A0Since the error is detected at IRQ context, and the PHY function=
s
>> try to sleep, the kernel ends up panicking.
>>
>> Resetting the PHY on an FEC error isn't even necessary. =A0This patch
>> solves the problem by removing the PHY reset entirely.
>
> There is also no need to free and re-allocate the RX buffers in
> mpc52xx_fec_reset().

Write and test a patch for me!  :-)

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
