Message-ID: <3CE0F23E.2FADEABB@etx.ericsson.se>
Date: Tue, 14 May 2002 13:17:18 +0200
From: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
MIME-Version: 1.0
To: Sangmoon Kim <dogoil@etinsys.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: File System on 64-bit-bus-width Flash memory
References: <000b01c1fb37$50751cf0$1a11efcb@industrialDiv.hanasys.co.kr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sangmoon Kim wrote:
>
> Hi,
> I want to make a flash file system on a custom MPC755 board with a 64-bit (bus width) flash memory.
> I set CONFIG_MTD_PHYSMAP_BUSWIDTH = 8 at kernel configure, and when it boots the following message appears.
>
> physmap flash device: 400000 at 7c000000
> genprobe_new_chip called with unsupported buswidth 8
> CFI: Found no Physically mapped flash device at location zero
>
> Is it possible to make a flash file system with a flash memory of  64 bit bus width? If possible, what's the method? Please let me know.

You could fix it so it can handle buswith 8 or you could write a mapping
driver that fakes buswidth 4. The simplest is to make the first 32 bits of
the bus one region and the last 32bits another. So if you have 8MiB you get
4MiB only using the first 32 bits followed by 4MiB using the hi 32 bits. This
way the autdetetcion should work ok.


--
Kenneth Johansson
Ericsson AB                       Tel: +46 8 404 71 83
Borgafjordsgatan 9                Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@etx.ericsson.se

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
