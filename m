Return-Path: <wojciech.kromer@dgt.com.pl>
Received: from dgt.com.pl (mail.dgt.com.pl [195.117.141.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 50FB6679E8
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Feb 2006 01:16:34 +1100 (EST)
Message-ID: <43F08EF7.3060109@dgt.com.pl>
Date: Mon, 13 Feb 2006 14:51:51 +0100
From: Wojciech Kromer <wojciech.kromer@dgt.com.pl>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: arch/ppc/82xx_io/uart.c bug found
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

here is orignal uart.c

#ifdef SCC_CONSOLE
                                switch (state->smc_scc_num) {
                                case 0:
                                        page = CPM_CR_SCC1_PAGE;
                                        sblock = CPM_CR_SCC1_SBLOCK;
                                        break;
                                case 1:
                                        page = CPM_CR_SCC2_PAGE;
                                        sblock = CPM_CR_SCC2_SBLOCK;
                                        break;
                                case 2:
                                        page = CPM_CR_SCC3_PAGE;
                                        sblock = CPM_CR_SCC3_SBLOCK;
                                        break;
                                }
....


 so SCC4 is unusable, here is missing code:

                                case 3:
                                        page = CPM_CR_SCC4_PAGE;
                                        sblock = CPM_CR_SCC4_SBLOCK;
                                        break;
                                }
