Message-Id: <200310230755.h9N7tLIr024281@blooper.utfors.se>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>
To: linuxppc-embedded@lists.linuxppc.org
Subject: __restore_flags shows in kernel profile
Date: Thu, 23 Oct 2003 09:55:21 +0200
MIME-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I did a kernel profile(included below) of the bootup of my custom MPC862 board and I
noticed that __restore_flags gets a very high count. I am suprised that such a small
assembler routine gets such a high count. __cli, _save_flags_ptr and __sti are much lower.
A small test program with a tight select loop on fds 0,1 or 2 also makes __restore_flags
go wild.
Anyone know why?

Also, I don't understand what all these nops in __restore_flags,
__save_flags_ptr, __cli and __sti are for. Anyone know?

  Jocke

[SNIP]
    3 __cli                                      0.0375
    3 __save_flags_ptr                     0.0375
    32 __sti                                     0.4000
[SNIP]
    82 memcpy                                     0.6833
   101 zlib_inflate_blocks                        0.0309
   108 __flush_dcache_icache                  3.0000
   115 __restore_flags                            1.0648
   139 cpm_iic_read                               0.1746
   181 copy_page                                  2.2625
   262 huft_build                                 0.1845
   401 crc32_le                                   1.4120
   714 zlib_inflate_fast                          0.5833
  6186 idled                                    110.4643
  9649 total                                      0.0078

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
