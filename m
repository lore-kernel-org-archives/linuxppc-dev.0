Return-Path: <linuxppcdev@qbjnet.com>
Received: from kunk.qbjnet.com (ddsl1-28.ddsl.mr.net [137.192.135.28])
	by ozlabs.org (Postfix) with SMTP id B1FEE683E3
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Oct 2005 12:11:30 +1000 (EST)
Date: 3 Oct 2005 02:11:29 -0000
Message-ID: <20051003021129.20564.qmail@kunk.qbjnet.com>
From: Bob Brose <linuxppcdev@qbjnet.com>
To: linuxppc-dev@ozlabs.org
Subject: Q: signed vs unsigned char,
	PPC vs x86 gcc 3.3.5 compiler differences
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm trying to fix some of the AX25 code in the 2.6 kernel and traced down
a problem to the use of a char var which was being assigned
the value of -1. On x86 when the var was compared to -1 it succeded but
on PPC it failed. So I tried a simple test:

main()
{
char atest;
atest=-1;
printf("%i,%X\n",atest,atest);
}

With GCC 3.3.5 on 2.6.14-rc1 x86 I get:
./atest
-1,FFFFFFFF

With GCC 3.3.5 on 2.6.14-rc1 PPC I get:
./atest
255,FF

If I change the declaration of atest to a signed char on PPC I get the
same result as x86.

Does this mean the char in x86 is signed and in PPC it's unsigned?
Has it always been thus?
 
