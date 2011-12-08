Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 334BF1007D1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Dec 2011 01:02:59 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 02789-02 for <linuxppc-dev@lists.ozlabs.org>;
 Thu,  8 Dec 2011 14:02:48 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] powerpc: POWER7 optimised copy_to_user/copy_from_user
 using VMX
Date: Thu, 8 Dec 2011 14:02:39 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AF0A@saturn3.aculab.com>
In-Reply-To: <700CAC5A-AD1A-48BA-BD74-CB9FBB325484@kernel.crashing.org>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Segher Boessenkool" <segher@kernel.crashing.org>,
 "Anton Blanchard" <anton@samba.org>
Cc: paulus@samba.org, Michael Neuling <mikey@neuling.org>,
 sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> > One idea would be to have a structure of function pointers for each
> > CPU that gets runtime patched into the right places,=20
> > similar to how we do some of the MMU fixups.
>=20
> Sounds good to me :-)

Except the indirect jump/call is almost certainly
never predicted - so will be slow.

You might want to patch jump instructions instead.

The same is true for in-kernel memcpy() and other
similar operations.

I actually wonder sometimes what the typical lengths
are for these sort of functions, and whether, in fact,
small lengths dominate - where the fixed costs matter.

	David
