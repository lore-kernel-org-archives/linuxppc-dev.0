Return-Path: <dgaur@cdotd.ernet.in>
Received: from sandesh.cdotd.ernet.in (sandesh.cdotd.ernet.in [196.1.105.47])
	by ozlabs.org (Postfix) with ESMTP id E9933DDE09
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 Nov 2007 22:44:44 +1100 (EST)
Received: from sandesh.cdotd.ernet.in (localhost [127.0.0.1])
	by localhost.cdotd.ernet.in (Postfix) with ESMTP id 8FC36185936
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 Nov 2007 16:56:37 +0530 (IST)
Received: from mail1.cdotd.ernet.in (mail1.cdotd.ernet.in [196.1.105.196])by
	sandesh.cdotd.ernet.in (Postfix) with ESMTP id 71328185934for
	<linuxppc-embedded@ozlabs.org>; Mon, 12 Nov 2007 16:56:37 +0530 (IST)
Received: from cdotd.ernet.in (localhost.localdomain [127.0.0.1])by
	mail1.cdotd.ernet.in (8.12.5/8.12.5) with ESMTP id lACBtXjR001374for
	<linuxppc-embedded@ozlabs.org>; Mon, 12 Nov 2007 17:25:34 +0530
From: "Deepak Gaur" <dgaur@cdotd.ernet.in>
To: linuxppc-embedded@ozlabs.org
Subject: Modulo operation in C for -ve values
Date: Mon, 12 Nov 2007 17:25:33 +0530
Message-Id: <20071112115350.M72594@cdotd.ernet.in>
In-Reply-To: <200711121901.39163.rusty@rustcorp.com.au>
References: <1194564963-15626-1-git-send-email-Emilian.Medve@Freescale.com><
	18231.60427.229658.485287@cargo.ozlabs.ibm.com>
	<200711121901.39163.rusty@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The Modulo operation as specified in
http://xenia.media.mit.edu/~bdenckla/thesis/texts/htthe/node13.html says that
for a fraction like n/k which can be expressed as n/k = i + j/k the C division
and mod operation should yeild
n div k = i (integer part)
n mod k = j (remainder part)
For n +ve above is true
For n -ve
-n/k = -i + j/k
-n div k = -i
-n mod k = j (+ve remainder)

But running a sample program on Redhat enterprise Linux EL4
with libc-2.3.4 gcc version 3.4.3 20041212 (Red Hat 3.4.3-9.EL4)
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
int main()
{
int n,k,j;
n=-3;
k=8;
j=(n/k);
printf("\n n div k %d", j);
j=(n%k);
printf("\n n mod k %d", j);
}
gives following output for n = -3 k = 8
n div k 0
n mod k  -3
though it should have been as per hypothesis proposed in
http://xenia.media.mit.edu/~bdenckla/thesis/texts/htthe/node13.html
n div k -1
n mod k  5

Which is correct(0,-3) or (-1,5)? 

Thanks
Deepak Gaur
