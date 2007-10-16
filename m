Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 7131EDDECD
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 06:19:21 +1000 (EST)
Date: Tue, 16 Oct 2007 15:25:25 -0500
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org, benh@kernel.crashing.org
Subject: New time code miscalculates cpu usage
Message-ID: <20071016202525.GA11837@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Not sure when this started happening, but I wanted to report it. I'll
start bisecting in a day or two if noone else has gotten around to
looking at it:

$ echo "int main(void) { while(1); }" > test.c ; gcc test.c
$ time ./a.out & sleep 2 ; killall a.out
real    0m2.008s
user    0m4.014s
sys     0m0.002s

Seen on POWER5 and PA6T, haven't tried anything else yet.


-Olof
