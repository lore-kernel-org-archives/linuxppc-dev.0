Return-Path: <ntl@pobox.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 61430B726E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 12:34:20 +1000 (EST)
To: subrata@linux.vnet.ibm.com
Subject: Re: [PATCH] Re:[BUILD FAILURE 04/04] Next June 04:PPC64 randconfig
	[drivers/net/ucc_geth.o]
References: <20090610174323.28045.70169.sendpatchset@subratamodak.linux.ibm.com>
	<20090611110523.1fd56a41.sfr@canb.auug.org.au>
	<1244685364.6494.14.camel@subratamodak.linux.ibm.com>
From: Nathan Lynch <ntl@pobox.com>
Date: Wed, 10 Jun 2009 21:28:30 -0500
In-Reply-To: <1244685364.6494.14.camel@subratamodak.linux.ibm.com> (Subrata
	Modak's message of "Thu\, 11 Jun 2009 07\:26\:04 +0530")
Message-ID: <m3d49btsfl.fsf@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sachin P Sant <sachinp@linux.vnet.ibm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>, netdev@vger.kernel.org,
	Linux-Kernel <linux-kernel@vger.kernel.org>,
	Linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	Linux-Next <linux-next@vger.kernel.org>, Li Yang <leoli@freescale.com>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Subrata Modak <subrata@linux.vnet.ibm.com> writes:

> On Thu, 2009-06-11 at 11:05 +1000, Stephen Rothwell wrote:
>> Hi Subrata,
>>=20
>> On Wed, 10 Jun 2009 23:13:23 +0530 Subrata Modak <subrata@linux.vnet.ibm=
.com> wrote:
>> >
>> >  	/* Find the TBI PHY.  If it's not there, we don't support SGMII */
>> > -	ph =3D of_get_property(np, "tbi-handle", NULL);
>> > +	ph =3D (phandle *)of_get_property(np, "tbi-handle", NULL);
>>=20
>> You don't need this cast because of_get_property() returns "void *".
>
> Stephen,
>
> True. But without this gcc complains:
>
> CC [M]  drivers/net/ucc_geth.o
> drivers/net/ucc_geth.c: In function =E2=80=98ucc_geth_probe=E2=80=99:
> drivers/net/ucc_geth.c:3824: warning: assignment discards qualifiers
> from pointer target type

ph should be declared const phandle *.  Look at other uses of
of_get_property.
