MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Bug in sharp.c flash driver
Date: Mon, 4 Nov 2002 13:30:12 +0200
Message-ID: <1E354700654661418593A0D6B5A9D410A362C7@mail.azisa.co.za>
From: "Flavio Pereira" <fpereira@azisa.com>
To: "Wolfgang Denk" <wd@denx.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Wolfgang

I finally sorted out my MTD problems. It turns out that there is a
problem in drvivers/mtd/sharp.c. In function sharp_erase

	if (instr->callback) {
		instr->callback(instr);
	}

instr->state never gets set so the mtd driver never exits. We need to
set the state before this if statement:

instr->state = MTD_ERASE_DONE;

Regards
Flavio Pereira


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
