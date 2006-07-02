Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 4834467A64
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Jul 2006 13:54:59 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C69D8B.48ACF54D"
Subject: RE: [PATCH] powerpc:Fix rheap alignment problem
Date: Sat, 1 Jul 2006 22:54:57 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B07B36F@ismail.innsys.innovsys.com>
References: <9FCDBA58F226D911B202000BDBAD467306E04FF6@zch01exm40.ap.freescale.net><20060701102557.GA14013@lst.de><C4F75531-D046-42EF-AAF7-D45B84DA1720@kernel.crashing.org>
	<200607011750.05019.pantelis.antoniou@gmail.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Pantelis Antoniou" <pantelis.antoniou@gmail.com>,
	"Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C69D8B.48ACF54D
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

From: Pantelis Antoniou
Sent: Sat 7/1/2006 9:50 AM
>Since genalloc is the blessed linux thing it might be best to use that =
& remove
>rheap completely. Oh well...

Two problems with genalloc that I can see (for CPM programming):
1) (minor) Does not have a way to specify alignment (genalloc does it =
for you)
2) (major problerm, at least for me) Does not have a way to allocate a =
specified address in the pool.

2 is needed esp when programming MCC drivers, since a lot of the =
datastructures must be in DP RAM _and_ be in a specific spot. And if you =
cannot tell the allocator that I am using a specific address, then the =
allocator might very well give somebody else that portion of RAM. The =
only solution without a fixed allocator is to allocate ALL memory in the =
DP RAM and use your own allocator.=20

------_=_NextPart_001_01C69D8B.48ACF54D
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7233.69">
<TITLE>RE: [PATCH] powerpc:Fix rheap alignment problem</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>From: Pantelis Antoniou<BR>
Sent: Sat 7/1/2006 9:50 AM<BR>
&gt;Since genalloc is the blessed linux thing it might be best to use =
that &amp; remove<BR>
&gt;rheap completely. Oh well...<BR>
<BR>
Two problems with genalloc that I can see (for CPM programming):<BR>
1) (minor) Does not have a way to specify alignment (genalloc does it =
for you)<BR>
2) (major problerm, at least for me) Does not have a way to allocate a =
specified address in the pool.<BR>
<BR>
2 is needed esp when programming MCC drivers, since a lot of the =
datastructures must be in DP RAM _and_ be in a specific spot. And if you =
cannot tell the allocator that I am using a specific address, then the =
allocator might very well give somebody else that portion of RAM. The =
only solution without a fixed allocator is to allocate ALL memory in the =
DP RAM and use your own allocator.<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C69D8B.48ACF54D--
