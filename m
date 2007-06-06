Return-Path: <matvejchikov@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.183])
	by ozlabs.org (Postfix) with ESMTP id 86D16DDEBD
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Jun 2007 22:30:19 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z74so371637pyg
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 06 Jun 2007 05:30:14 -0700 (PDT)
Message-ID: <8496f91a0706060530o57ebb3e4nf87ae4f566ea2e4e@mail.gmail.com>
Date: Wed, 6 Jun 2007 16:30:14 +0400
From: "Matvejchikov Ilya" <matvejchikov@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: cpm_setbrg problem
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Reply-To: matvejchikov@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all!

There is a problem in cpm_setbrg (arch/powerpc/sysdev/cpm2_common.c
file) function. When rate 9600 all is OK, but with 115200 it doesn't
work properly. As I see it the following is incorrect:
          *bp = ((BRG_UART_CLK / rate) << 1) | CPM_BRG_EN;
it must be
          *bp = (((BRG_UART_CLK / rate) - 1) << 1) | CPM_BRG_EN;

Best regards,
Matvejchikov Ilya.
