Message-ID: <762A181C0D966E459A2EB3B810142C7701514BF0@nmrusdunsx12.nmrlan.net>
From: "Wells, Charles" <Charles.Wells@nielsenmedia.com>
To: "'li'" <slowforce@21cn.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: need a fast byteorder changing routine
Date: Fri, 18 Jul 2003 09:03:35 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Li,

There's several ways of doing it.  This way is pretty fast and makes few
assumptions about the buffer.

void FixEndian(long* buf, unsigned long num_longs)
{
  __asm__(" addi   3,3,-4");
  __asm__(" mtspr  9,4");
  __asm__(" lwzu   4,4(3)");
  __asm__(" stwbrx 4,0,3");
  __asm__(" bc     16,0,$-8");
}

Charlie

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
