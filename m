Return-Path: <wilbur512@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CEBFEB7257
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Aug 2009 00:46:35 +1000 (EST)
Received: from mail-gx0-f215.google.com (mail-gx0-f215.google.com
	[209.85.217.215]) by ozlabs.org (Postfix) with ESMTP id 3971FDDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2009 00:46:34 +1000 (EST)
Received: by gxk11 with SMTP id 11so249822gxk.16
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Aug 2009 07:46:33 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 26 Aug 2009 22:39:24 +0800
Message-ID: <e997b7420908260739u49fb4b36j9eb148782829547b@mail.gmail.com>
Subject: Can't write value into memory ?(E500 V2)
From: "wilbur.chan" <wilbur512@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In  an assemblely code ,   I invalided all the TLB entries except for
the entry  we are executed in.

After that , I setuped a 1:1 TLB entry mapping of 1GB .

At last , I wrote value 30 into the physical address 0x0400,0000 (also
the virtual address because of my 1:1 mapping).

However, it seemed failed to store the value '30' at address
0x400,0000. The following is my code:

//code start

// setup a 1:1 mapping of 1GB
...
//store '30' into address 0x0400,0000

li  r23, 30
lis r22, 0x400
ori r22,r22,0x0
stb  r23,0(r22)


//check if we successfully store value at 0x400,0000

lis r22, 0x400
ori r22,r22,0x0
lwz r23,0(r22)
cmpw r23, 30
beq  print_equal

1: b 1b

print_equal:
 ...
//code end

I found that, print_equal was not called ,the whole code seemed  to
enter an  infinite loop.

Can anyone plz tell me why this happended?


Thanks in advance.


regards,

wilbur
