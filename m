Return-Path: <atulsdeshmukh@gmail.com>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) by ozlabs.org (Postfix) with ESMTP id 4C5B2B70CE
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  2 Aug 2010 22:38:17 +1000 (EST)
Received: by iwn39 with SMTP id 39so4624795iwn.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 02 Aug 2010 05:38:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTi=ke8Yiy39dONFkMPpm5H8vhRy1jVyaKLuG8r4e@mail.gmail.com>
References: <AANLkTi=ke8Yiy39dONFkMPpm5H8vhRy1jVyaKLuG8r4e@mail.gmail.com>
Date: Mon, 2 Aug 2010 18:08:14 +0530
Message-ID: <AANLkTikGL6LKJyWjK946enVwkUzviOsHasYbzV1Wj2LR@mail.gmail.com>
Subject: Issues to access Compact Flash Card on MPC8360E
From: Atul Deshmukh <atulsdeshmukh@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=001485e0e5586f87b8048cd679c4
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001485e0e5586f87b8048cd679c4
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I would like to have your expert opinion on one of our design issue to
access the Compact Flash on MPC8360E.

I'm building an embedded system that will access Compact Flash card on
MPC8360E through local bus and not through PCMCIA.

The issue is how to access the CF card i.e. whether in memory mapped/io
mapped/True IDE mode?

Following are some concerned points...

1: If we use PC-Card ATA memory mapped mode then we have to stick with
PCMCIA specs and we also need PCMCIA bus on our board and have to use 'CF to
PCMCIA adapter'. But I don't have that much space on the board.So how can I
use CF card in PC-Card ATA memory mapped mode without using adapter and what
kernel drivers we can use for that?

2: The second approach is to use True IDE but in this case also we need IDE
socket.
Can we use CF card using its own 50 pin connector only without using any
adapter.What drivers we can use for True-IDE mode?



I read the CF specs and digged into kernel code for drivers and came up with
some findings which could be right or wrong..
Pls put on your thoughts on it and correct me if i'm wrong.

1: To access CF card in "PC-Card ATA memory mapped/IO mapped" mode we have
to use PCMCIA subsystem of kernel where we can use low level socket driver
that do resource windows allocation and other low level operations. We also
have to use linux provided Card Services (linux-kernel-source/drivers/
pcmcia/cs.c) and Driver Services (linux-kernel-source/drivers/pcmcia/ds.c)
but we have to write our own client driver and application driver to access
those serives.....Am I going right way????

2: To access CF card in True IDE mode we have to use
"linux-kernel-source/drivers/ata/pata_platform.c" and
"linux-kernel-source/drivers/ata/libata-sff.c".....I'm going right??

Your suggestions would be really helpful....



-- 
Regards,
Atul

--001485e0e5586f87b8048cd679c4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">Hi,<br><br>I would like to have your expert opin=
ion on one of our design issue to access the Compact Flash on MPC8360E.<br>=
<br>I&#39;m building an embedded system that will access Compact Flash card=
 on MPC8360E through local bus and not through PCMCIA.<br>


<br>The issue is how to access the CF card i.e. whether in memory mapped/io=
 mapped/True IDE mode?<br><br>Following are some concerned points...<br><br=
>1:
If we use PC-Card ATA memory mapped mode then we have to stick with
PCMCIA specs and we also need PCMCIA bus on our board and have to use
&#39;CF to PCMCIA adapter&#39;. But I don&#39;t have that much space on the=
 board.So
how can I use CF card in PC-Card ATA memory mapped mode without using
adapter and what kernel drivers we can use for that?<br>
<br>2: The second approach is to use True IDE but in this case also we need=
 IDE socket. <br>Can we use CF card using its own 50 pin connector only wit=
hout using any adapter.What drivers we can use for True-IDE mode?<br><br>


<br><br>I read the CF specs and digged into kernel code for drivers and cam=
e up with some findings which could be right or wrong..<br>Pls put on your =
thoughts on it and correct me if i&#39;m wrong.<br><br>1:
To access CF card in &quot;PC-Card ATA memory mapped/IO mapped&quot; mode w=
e have
to use PCMCIA subsystem of kernel where we can use low level socket
driver that do resource windows allocation and other low level
operations. We also have to use linux provided Card Services
(linux-kernel-source/drivers/<div>pcmcia/cs.c) and Driver Services (linux-k=
ernel-source/drivers/pcmcia/ds.c)
but we have to write our own client driver and application driver to
access those serives.....Am I going right way????<br>
<br>2: To access CF card in True IDE mode we have to use &quot;linux-kernel=
-source/drivers/ata/pata_platform.c&quot; and &quot;linux-kernel-source/dri=
vers/ata/libata-sff.c&quot;.....I&#39;m going right??<br><br>Your suggestio=
ns would be really helpful....<br>


</div><br clear=3D"all"><br><br></div>-- <br>Regards,<br>Atul <br><br>=A0 <=
br>

--001485e0e5586f87b8048cd679c4--
