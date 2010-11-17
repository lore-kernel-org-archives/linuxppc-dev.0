Return-Path: <Shan.Hai@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id B4E0EB717B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Nov 2010 13:24:07 +1100 (EST)
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id oAH2O5GL001824
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Nov 2010 18:24:05 -0800 (PST)
From: Shan Hai <shan.hai@windriver.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: math_efp.c: Fixed SPE data type conversion failure
Date: Wed, 17 Nov 2010 10:28:52 +0800
Message-Id: <1289960933-5172-1-git-send-email-shan.hai@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The following test case failed on Powerpc sbc8548 with CONFIG_SPE

static float fm;
static signed int si_min = (-2147483647 - 1);
static unsigned int ui;
int main()
{
        fm = (float) si_min; ;
        ui = (unsigned int)fm;
        printf("ui=%d, should be %d\n", ui, si_min);

        return 0;
}
Result: ui=-1, should be -2147483648

The reason is failure to emulate the minus float to unsigned integer conversion 
instruction in the SPE driver.
