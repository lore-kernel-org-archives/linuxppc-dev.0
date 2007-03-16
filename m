Return-Path: <aldo.lab@gmail.com>
Received: from hu-out-0506.google.com (hu-out-0506.google.com [72.14.214.226])
	by ozlabs.org (Postfix) with ESMTP id 6B38FDDED4
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Mar 2007 05:36:18 +1100 (EST)
Received: by hu-out-0506.google.com with SMTP id 16so2541605hue
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Mar 2007 11:36:15 -0700 (PDT)
Message-ID: <6e41d1460703161136q7afb3077r49b11cb9a123c124@mail.gmail.com>
Date: Fri, 16 Mar 2007 19:36:15 +0100
From: "aldo lab" <aldo.lab@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: m8260_map_io
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I've seen a region of 256MB starting from 0xe0000000 that is io
blocking with a BAT filled with Inhibit cache and guarded.
do you know which is the reason of this mapping because is not so
clear from the code.

201 static void __init
202 m8260_map_io(void)
203 {
204         uint addr;
205
206         /* Map IMMR region to a 256MB BAT */
207         addr = (cpm2_immr != NULL) ? (uint)cpm2_immr : CPM_MAP_ADDR;
208         io_block_mapping(addr, addr, 0x10000000, _PAGE_IO);
209
210         /* Map I/O region to a 256MB BAT */
211         io_block_mapping(IO_VIRT_ADDR, IO_PHYS_ADDR, 0x10000000, _PAGE_IO);
212 }
213



Thank you
Aldo
