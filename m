Mime-Version: 1.0
Message-Id: <v04220801b5b2d307b692@[10.0.0.42]>
In-Reply-To: <398CDA96.C3CBE4C@denise.shiny.it>
References: <39861753.8DB68BB6@denise.shiny.it>
 <20000731184228.18405@192.168.1.10> <398CDA96.C3CBE4C@denise.shiny.it>
Date: Sun, 6 Aug 2000 02:33:17 -0700
To: Giuliano Pochini <pochini@denise.shiny.it>,
        Benjamin Herrenschmidt <bh40@calva.net>
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: progress on l2cr
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: multipart/mixed; boundary="============_-1246568096==_============"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--============_-1246568096==_============
Content-Type: text/plain; charset="us-ascii" ; format="flowed"

At 11:25 PM -0400 8/5/00, Giuliano Pochini wrote:
>>  >> >Is there any reason to keep the L2 cache data-only ?
>>  >>
>>  >> There are some rare cases where it can be useful, yes. Like when flushing
>>  >> it, to avoid the flush code to pollute it.
>>  >
>>  >A few bytes inside a 1MB cache are't a problem IMHO. Anyway I
>>enabled it and
>>  >performance compiling programs is 15% lower.
>>
>>  You have no reason to enable "data only" in normal use. It's used during
>>  the flush cycle of the cache to avoid polluting it while the flush code
>>  runs, but it's set and unset automatically, so you don't need to care.
>
>Ok, but /proc/.../l2cr tells it's data-only at boot.

It's lying.

There is a longstanding bug in the kernel L2CR printout routine.  The
kernel routine prints "data only" if the L2DO bit in L2CR is 0.
However, the actual meaning of this bit is 0 = data only mode off, 1
= data only mode on.

This kernel bug probably happened because early revisions of
Motorola's MPC750 manual have several errors in the L2CR section,
including an error about the interpretation of L2DO.  Early revision
Motorola processor manuals are very dangerous things and should not
be relied upon to get anything right (you should see the errata list
for the MPC8260 manual).

Unfortunately, this documentation-caused kernel bug seems to have
slipped through the cracks.


Ben, could you get this patch to fix L2CR reporting into the official
kernel?  It does the following things:

1. Fixes L2DO reporting as discussed above.

2. Fixes cache type reporting (the 2-bit cache memory type field
should be masked using a mask value of 0x03 not 0x02).

3. Sanitizes code so that only one method is used to extract bit
fields from L2CR (better readability)

4. Uses a more sensible format for reporting the L2 cache clock (the
old "+2 clock", "+1.5 clock" stuff doesn't make sense, since we're
reporting the ratio between the processor core clock and the L2 cache
clock, not a delta.)

5. Saves a few bytes of memory by having shorter clock ratio string constants.
--============_-1246568096==_============
Content-Id: <v04220801b5b2d307b692@[10.0.0.42].0.0>
Content-Type: application/octet-stream; name="ppc_htab.c.patch"
 ; x-mac-type="54455854"
 ; x-mac-creator="522A6368"
Content-Disposition: attachment; filename="ppc_htab.c.patch"
 ; modification-date="Sun, 6 Aug 2000 02:24:51 -0700"
Content-Transfer-Encoding: x-uuencode

begin 644 ppc_htab.pat
M+2TM(&%R8V@O<'!C+VME<FYE;"]P<&-?:'1A8BYC+F]R:6<)4W5N($%U9R`@
M-B`P,3HT.#HT-"`R,#`P"BLK*R!A<F-H+W!P8R]K97)N96PO<'!C7VAT86(N
M8PE3=6X@075G("`V(#`R.C$U.C`W(#(P,#`*0$`@+34S-BPX("LU,S8L."!`
M0`H@"0DB=6YK;F]W;B!S:7IE(BP@(C(U-DM"(BP@(C4Q,DM"(BP@(C%-0B(*
M(`E].PH@"7-T871I8R!C;VYS="!C:&%R("IC;&]C:W-T<FEN9W-;.%T@/2![
M"BT)"2)C;&]C:R!D:7-A8FQE9"(L("(K,2!C;&]C:R(L("(K,2XU(&-L;V-K
M(BP@(G)E<V5R=F5D*#,I(BP*+0D)(BLR(&-L;V-K(BP@(BLR+C4@8VQO8VLB
M+"`B*S,@8VQO8VLB+"`B<F5S97)V960H-RDB"BL)"2)D:7-A8FQE9"(L("(Q
M.C$B+"`B,2XU.C$B+"`B<F5S97)V960H,RDB+`HK"0DB,CHQ(BP@(C(N-3HQ
M(BP@(C,Z,2(L(")R97-E<G9E9"@W*2(*(`E].PH@"7-T871I8R!C;VYS="!C
M:&%R("IT>7!E<W1R:6YG<ULT72`]('L*(`D)(F9L;W<M=&AR;W5G:"!B=7)S
M="!34D%-(BP@(G)E<V5R=F5D(%-204TB+`I`0"`M-3DW+#$S("LU.3<L,3(@
M0$`*(`D)"0DJ<"LK(#T@)UQT)SL*(`D)"79A;"`](%]G971?3#)#4B@I.PH@
M"0D)<"`K/2!S<')I;G1F*'`L("(E,#AX.B`B+"!V86PI.PHM"0D)<"`K/2!S
M<')I;G1F*'`L("(@)7,B+`HM"0D)"2`@("`@*'9A;"8P>#@P,#`P,#`P*3\B
M96YA8FQE9"(Z(F1I<V%B;&5D(BD["BT)"0EP("L]('-P<FEN=&8H<"PB+"5S
M<&%R:71Y(BPH=F%L)C!X-#`P,#`P,#`I/R(B.B)N;R`B*3L**PD)"7`@*ST@
M<W!R:6YT9BAP+"(@)7,B+"AV86P^/C,Q*28Q/R)E;F%B;&5D(CHB9&ES86)L
M960B*3L**PD)"7`@*ST@<W!R:6YT9BAP+"(L)7-P87)I='DB+"AV86P^/C,P
M*28Q/R(B.B)N;R`B*3L*(`D)"7`@*ST@<W!R:6YT9BAP+"`B+"5S(BP@<VEZ
M97-T<FEN9W-;*'9A;"`^/B`R."D@)B`S72D["BT)"0EP("L]('-P<FEN=&8H
M<"P@(BPE<R(L(&-L;V-K<W1R:6YG<ULH=F%L(#X^(#(U*2`F(#==*3L*+0D)
M"7`@*ST@<W!R:6YT9BAP+"`B+"5S(BP@='EP97-T<FEN9W-;*'9A;"`^/B`R
M,RD@)B`P>#)=*3L*+0D)"7`@*ST@<W!R:6YT9BAP+"(E<R(L*'9A;#X^,C(I
M)C$_(B(Z(BQD871A(&]N;'DB*3L**PD)"7`@*ST@<W!R:6YT9BAP+"`B+"5S
M(&-L;V-K(BP@8VQO8VMS=')I;F=S6RAV86P@/CX@,C4I("8@-UTI.PHK"0D)
M<"`K/2!S<')I;G1F*'`L("(L)7,B+"!T>7!E<W1R:6YG<ULH=F%L(#X^(#(S
M*2`F(#-=*3L**PD)"7`@*ST@<W!R:6YT9BAP+"(E<R(L*'9A;#X^,C(I)C$_
M(BQD871A(&]N;'DB.B(B*3L*(`D)"7`@*ST@<W!R:6YT9BAP+"(E<R(L*'9A
M;#X^,C`I)C$_(BQ:6B!E;F%B;&5D(CHB(BD["B`)"0EP("L]('-P<FEN=&8H
M<"PB+"5S(BPH=F%L/CXQ.2DF,3\B=W)I=&4M=&AR;W5G:"(Z(F-O<'DM8F%C
M:R(I.PH@"0D)<"`K/2!S<')I;G1F*'`L(BPE<VYS(&AO;&0B+"!H;VQD<W1R
4:6YG<ULH=F%L/CXQ-BDF,UTI.PH`
`
end

--============_-1246568096==_============
Content-Type: text/plain; charset="us-ascii" ; format="flowed"


   Tim Seufert
--============_-1246568096==_============--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
