Date: Wed, 15 Aug 2001 14:03:29 -0400 (EDT)
From: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>
To: Dan Malek <dan@mvista.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: flush_dcache_range problems
In-Reply-To: <Pine.LNX.4.33.0108150124050.4298-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0108151346380.21093-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 15 Aug 2001, Justin (Gus) Hurwitz wrote:

>
> On Tue, 14 Aug 2001, Dan Malek wrote:


> ---
>
> Hold a second- I lied, and I lied bigtime. I forgot that I had a hole
> punched in the firewall at work, and and ftp server running on the PC that
> had my logs on it (don't tell anyone):
>
> Oops: kernel access of bad area, sig: 11
> NIP: C0006048 XER: 20000000 LR: C01366D8 SP: C03C5F20 REGS: c03c5e70 TRAP: 0300
> MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> DAR: C8000000, DSISR: 20000000
> TASK = c03c4000[1] 'swapper' Last syscall: 120
> last math 00000000 last altivec 00000000
> GPR00: 00000000 C03C5F20 C03C4000 C8000000 01C0228D 0000001F C7FBD19C C009F638
> GPR08: C009F62C 07FBC000 C009E3E8 C009D73C 44002024 00000000 00000000 00000000
> GPR16: 00000000 00000000 00000000 00000000 003FF000 00000000 00000000 00000000
> GPR24: 00000000 00000000 C0130000 C0100000 C0126528 C03C5F30 C01264B8 C7FBC000
> Call backtrace:
> C0136614 C013623C C0136350 C0136A40 C0135170 C012E7B0 C012E7F8
> C0003AF8 C00064CC
>
>
> Those last three addresses in the bt correspond the the functions I
> mentioned above.
>
> I'm going to go grab my notebook and spend some time mucking with the code
> (removing my attempts to allocte the memory as non-cacheable (or,
> ifdef'ing it out)).

OK- I'm now running with L1 cache enabled, and am no longer trying to
allocate non-cacheable memory. I am crashing later in the bootup process
(before it was in i82596_probe, now it's when trying to bring up the
chip).

Here's the crash:

NIP: C0006048 XER: 20000000 LR: C009DB5C SP: C03C5EE0 REGS: c03c5e30 TRAP: 0300
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: C8000000, DSISR: 20000000
TASK = c03c4000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: FFFF8008 C03C5EE0 C03C4000 C8000000 0007A120 0000001F C7FBE3E8 C7FBE280
GPR08: FFFFFFFF C7FBE3E8 C7FBE400 E28007FB 82000022 00000000 00000000 00000000
GPR16: 00000000 00000000 00000000 00000000 003FF000 00000000 00000000 00000000
GPR24: C03C5EE8 00000000 C0130000 C01264B8 00000000 C7FBE000 C7FBE5E0 C7FBE620
Call backtrace:
C009D908 C00A7ABC C00A9344 C0137BB4 C01381C8 C012E7B0 C012E7F8
C0003AF8 C00064CC

c009d854 <i596_open>
c00a7a58 <dev_open>
c00a92d8 <dev_change_flags>
c0137a78 <ic_open_devs>
c013814c <ip_auto_config>
c012e780 <do_initcalls>

And, from i596_open:
  c009d8fc:       38 60 06 10     li      r3,1552
  c009d900:       38 80 00 20     li      r4,32
  c009d904:       48 00 5f e5     bl      c00a38e8 <alloc_skb>
* c009d908:       7c 63 1b 79     mr.     r3,r3
  c009d90c:       41 82 00 20     beq     c009d92c <i596_open+0xd8>
  c009d910:       81 23 00 80     lwz     r9,128(r3)
  c009d914:       81 63 00 84     lwz     r11,132(r3)
  c009d918:       39 29 00 10     addi    r9,r9,16
  c009d91c:       39 6b 00 10     addi    r11,r11,16
  c009d920:       91 23 00 80     stw     r9,128(r3)
  c009d924:       91 63 00 84     stw     r11,132(r3)
  c009d928:       40 82 00 10     bne     c009d938 <i596_open+0xe4>
  c009d92c:       3c 60 c0 10     lis     r3,-16368
  c009d930:       38 63 6b b8     addi    r3,r3,27576
  c009d934:       4b f7 3b 71     bl      c00114a4 <panic>

(note, c009d908 is in init_rx_bufs, which is a static inline called from
i596_open).

C0006048 is still dcbst (from flush_dcache_range):

c0006044:       7c 89 03 a6     mtctr   r4
c0006048:       7c 00 18 6c     dcbst   r0,r3
c000604c:       38 63 00 20     addi    r3,r3,32



And the clock is now officially running: I have about 3 hours left working
on this project (before I move to the other side of the country).

Thanks :)
--Gus


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
