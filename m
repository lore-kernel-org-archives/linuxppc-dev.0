Message-ID: <7143C7BA3BFAD2119AAC0008C7094B9965043B@postoffice2.teltronics.com>
From: Tom Miles <tmiles@teltronics.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Checksum error on last record - Embedded Planet TFTP 
Date: Wed, 22 Mar 2000 16:14:38 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have corrected the checksum error on the last record when doing TFTP
downloads to a Embedded Planet CLLF board.  The zsrec program is putting a
''S9" record at the end of the file.  Apparently the Embedded Planet monitor
doesn't like "S9" records.

In zsrec.c, I replaced the following line:

	printf("S904000000FB\n");

with this line:

	printf("S70500200000DA\n");

This record (a start address record) then allows you to use the "T" command
in the "L"oad menu.  Which will load the image via TFTP and then start
execution at the address specified (i.e. 0x200000).


Tom Miles, Staff Engineer
Teltronics, Inc.
4125 Keller Springs Rd, #166
Addison, TX 75001-4213
972-818-2829 x2110
tmiles@teltronics.com
http://www.teltronics.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
