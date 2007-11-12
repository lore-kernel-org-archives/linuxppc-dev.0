Return-Path: <sfalco@harris.com>
Received: from mlbe2k1.cs.myharris.net (mlbe2k1.cs.myharris.net
	[137.237.90.88]) by ozlabs.org (Postfix) with ESMTP id AA4CADDE18
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 02:36:36 +1100 (EST)
Message-ID: <473872FF.4090109@harris.com>
Date: Mon, 12 Nov 2007 10:36:31 -0500
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: PPC440EPx on Sequoia: /proc/iomem acts weird
References: <4734A72B.2070104@harris.com> <20071109123522.072bc1d8@weaponx>
	<4734AAFC.8080907@harris.com> <200711101403.48792.sr@denx.de>
In-Reply-To: <200711101403.48792.sr@denx.de>
Content-Type: multipart/alternative;
	boundary="------------030105020801060607070101"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030105020801060607070101
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

This is on arch/powerpc.  I traced through the linked lists in 
resource.c.  Here is a partial list, with the addresses changed to 
single upper-case letters for readability.  Also "N" is a null pointer:

r=A p=N s=N c=K
r=K p=A s=M c=P
r=M p=A s=R c=N
r=R p=A s=B c=N
r=B p=B s=J c=B
r=J p=A s=C c=N
r=C p=A s=D c=N
r=D p=A s=E c=N
r=E p=A s=F c=N
r=F p=A s=G c=N
r=G p=A s=H c=N
r=H p=A s=N c=N
r=B p=B s=J c=B
r=J p=A s=C c=N
r=C p=A s=D c=N

r is the resource itself, p is the parent, s is the sibling, and c is 
the child.  As you can see, most nodes point back to parent "A", and 
have null children.  But one node, "B", points to itself both as parent 
and child.  I believe this is the problem, but I haven't confirmed that, 
nor have I determined how the list gets into this state.

    Steve


Stefan Roese wrote:
> Hi Steve,
>
> On Friday 09 November 2007, Steven A. Falco wrote:
>   
>> I am using the Denx 2.6.32 kernel, which does have powerpc/sequoia.
>> Xenomai is a real-time kernel built on Adeos/Ipipe.  I'll dig into it
>> further.
>>     
>
> Is this arch/ppc or arch/powerpc? I remember fixing this a while ago in 
> arch/ppc:
>
> commit 67a35ce785b1d11d09bf528c166ea26d489a4bd6
> Author: Stefan Roese <sr@denx.de>
> Date:   Thu Aug 2 14:15:22 2007 +0200
>
>     ppc: Fix problem with recursive NDFC platform_device resource management
>
>     This change fixes a problem with a resursive platform_device resource
>     management of the AMCC 4xx NDFC. Without this fix a "cat /proc/iomem"
>     leads to an infinite loop of printing the "ndfc-nand.0" resource.
>
>     Signed-off-by: Stefan Roese <sr@denx.de>
>
> Best regards,
> Stefan
>
>   

--------------030105020801060607070101
Content-Type: text/html; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-15"
 http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<tt>This is on arch/powerpc.  I traced through the linked lists in
resource.c.  Here is a partial list, with the addresses changed to
single upper-case letters for readability.  Also "N" is a null pointer:<br>
<br>
r=A p=N s=N c=K<br>
r=K p=A s=M c=P<br>
r=M p=A s=R c=N<br>
r=R p=A s=B c=N<br>
r=B p=B s=J c=B<br>
r=J p=A s=C c=N<br>
r=C p=A s=D c=N<br>
r=D p=A s=E c=N<br>
r=E p=A s=F c=N<br>
r=F p=A s=G c=N<br>
r=G p=A s=H c=N<br>
r=H p=A s=N c=N<br>
r=B p=B s=J c=B<br>
r=J p=A s=C c=N<br>
r=C p=A s=D c=N<br>
<br>
r is the resource itself, p is the parent, s is the sibling, and c is
the child.  As you can see, most nodes point back to parent "A", and
have null children.  But one node, "B", points to itself both as parent
and child.  I believe this is the problem, but I haven't confirmed
that, nor have I determined how the list gets into this state.<br>
<br>
    Steve<br>
<br>
</tt><br>
Stefan Roese wrote:
<blockquote cite="mid:200711101403.48792.sr@denx.de" type="cite">
  <pre wrap="">Hi Steve,

On Friday 09 November 2007, Steven A. Falco wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">I am using the Denx 2.6.32 kernel, which does have powerpc/sequoia.
Xenomai is a real-time kernel built on Adeos/Ipipe.  I'll dig into it
further.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Is this arch/ppc or arch/powerpc? I remember fixing this a while ago in 
arch/ppc:

commit 67a35ce785b1d11d09bf528c166ea26d489a4bd6
Author: Stefan Roese <a class="moz-txt-link-rfc2396E" href="mailto:sr@denx.de">&lt;sr@denx.de&gt;</a>
Date:   Thu Aug 2 14:15:22 2007 +0200

    ppc: Fix problem with recursive NDFC platform_device resource management

    This change fixes a problem with a resursive platform_device resource
    management of the AMCC 4xx NDFC. Without this fix a "cat /proc/iomem"
    leads to an infinite loop of printing the "ndfc-nand.0" resource.

    Signed-off-by: Stefan Roese <a class="moz-txt-link-rfc2396E" href="mailto:sr@denx.de">&lt;sr@denx.de&gt;</a>

Best regards,
Stefan

  </pre>
</blockquote>
</body>
</html>

--------------030105020801060607070101--
