Reply-To: <fabidi@ultsol.com>
From: "Fahd Abidi" <fabidi@ultsol.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: TLB and CSSBAR problems with MPC8540 and BDI2000
Date: Fri, 9 Jan 2004 12:40:37 -0500
Message-ID: <704F2B356FCC3E49A909C625BD9E5C4002143D@ultsol01.tewks.ultsol.local>
In-Reply-To: <3FFEDA13.5050509@gcctech.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have a customer trying to get kernel debugging working with the BDI2000,
currently he is experiencing this problem:

My board is crashing on this particular piece of code:

/* invalidate MMU L1/L2 */
/* Note: before invalidate MMU L1/L2, we read TLB1 Entry 0 and then
 * write it back immediately to fixup a bug(Errata CPU4)  for this
	initial
 * TLB1 entry 0,otherwise the TLB1 entry 0 will be invalidated.
 */
#if defined(CONFIG_MPC85xx_REV1)
	lis	r2,0x1000
	mtspr	MAS0,r2
	tlbre
	tlbwe
	isync
	li      r2, 0x001e
	mtspr   MMUCSR0, r2
	isync
#endif

I think my problem is all centered around TLB's and the CCSRBAR. I don't
know if the above code is part of the problem but at reset the cpu has
the CCSRBAR at 0xff700000 and there is a TLB entry mapped to its
location. My init code is moving the CCSRBAR and mapping a TLB to its
new location. I tried just moving the CCSRBAR back to its default
location. Do I also need to remap a TLB address to default location?

Thanks,
Matthew

Does anyone know the answer to this problem?

thanks,

Fahd


begin 666 ATT00010.htm
M/"%$3T-465!%($A434P@4%5"3$E#("(M+R]7,T,O+T141"!(5$U,(#,N,B\O
M14XB/@T*/$A434P^#0H\2$5!1#X-"CQ-151!($A45% M15%5258](D-O;G1E
M;G0M5'EP92(@0T].5$5.5#TB=&5X="]H=&UL.R!C:&%R<V5T/7=I;F1O=W,M
M,3(U,B(^#0H\345402!.04U%/2)'96YE<F%T;W(B($-/3E1%3E0](DU3($5X
M8VAA;F=E(%-E<G9E<B!V97)S:6]N(#8N,"XV,C0Y+C$B/@T*/%1)5$Q%/E1,
M0B!A;F0@0U-30D%2('!R;V)L96US('=I=&@@35!#.#4T,"!A;F0@0D1),C P
M,#PO5$E43$4^#0H\+TA%040^#0H\0D]$63X-"CPA+2T@0V]N=F5R=&5D(&9R
M;VT@=&5X="]P;&%I;B!F;W)M870@+2T^#0H-"CQ0/CQ&3TY4(%-)6D4],CY(
M:2P\+T9/3E0^#0H\+U ^#0H-"CQ0/CQ&3TY4(%-)6D4],CY)(&AA=F4@82!C
M=7-T;VUE<B!T<GEI;F<@=&\@9V5T(&ME<FYE;"!D96)U9V=I;F<@=V]R:VEN
M9R!W:71H('1H92!"1$DR,# P+"!C=7)R96YT;'D@:&4@:7,@97AP97)I96YC
M:6YG('1H:7,@<')O8FQE;3H\+T9/3E0^#0H\+U ^#0H-"CQ0/CQ&3TY4(%-)
M6D4],CY->2!B;V%R9"!I<R!C<F%S:&EN9R!O;B!T:&ES('!A<G1I8W5L87(@
M<&EE8V4@;V8@8V]D93H\+T9/3E0^#0H\+U ^#0H-"CQ0/CQ&3TY4(%-)6D4]
M,CXO*B!I;G9A;&ED871E($U-52!,,2],,B J+SPO1D].5#X-"@T*/$)2/CQ&
M3TY4(%-)6D4],CXO*B!.;W1E.B!B969O<F4@:6YV86QI9&%T92!-354@3#$O
M3#(L('=E(')E860@5$Q",2!%;G1R>2 P(&%N9"!T:&5N/"]&3TY4/@T*#0H\
M0E(^/$9/3E0@4TE:13TR/B9N8G-P.RH@=W)I=&4@:70@8F%C:R!I;6UE9&EA
M=&5L>2!T;R!F:7AU<"!A(&)U9RA%<G)A=&$@0U!5-"DF;F)S<#L@9F]R('1H
M:7,\+T9/3E0^#0H-"CQ"4CXF;F)S<#LF;F)S<#LF;F)S<#LF;F)S<#LF;F)S
M<#LF;F)S<#LF;F)S<#L@/$9/3E0@4TE:13TR/FEN:71I86P\+T9/3E0^#0H-
M"CQ"4CX\1D].5"!325I%/3(^)FYB<W [*B!43$(Q(&5N=')Y(# L;W1H97)W
M:7-E('1H92!43$(Q(&5N=')Y(# @=VEL;"!B92!I;G9A;&ED871E9"X\+T9/
M3E0^#0H-"CQ"4CX\1D].5"!325I%/3(^)FYB<W [*B\\+T9/3E0^#0H-"CQ"
M4CX\1D].5"!325I%/3(^(VEF(&1E9FEN960H0T].1DE'7TU00S@U>'A?4D56
M,2D\+T9/3E0^#0H-"CQ"4CXF;F)S<#LF;F)S<#LF;F)S<#LF;F)S<#LF;F)S
M<#LF;F)S<#LF;F)S<#L@/$9/3E0@4TE:13TR/FQI<R9N8G-P.R9N8G-P.R9N
M8G-P.R9N8G-P.R!R,BPP>#$P,# \+T9/3E0^#0H-"CQ"4CXF;F)S<#LF;F)S
M<#LF;F)S<#LF;F)S<#LF;F)S<#LF;F)S<#LF;F)S<#L@/$9/3E0@4TE:13TR
M/FUT<W!R)FYB<W [)FYB<W [($U!4S L<C(\+T9/3E0^#0H-"CQ"4CXF;F)S
M<#LF;F)S<#LF;F)S<#LF;F)S<#LF;F)S<#LF;F)S<#LF;F)S<#L@/$9/3E0@
M4TE:13TR/G1L8G)E/"]&3TY4/@T*#0H\0E(^)FYB<W [)FYB<W [)FYB<W [
M)FYB<W [)FYB<W [)FYB<W [)FYB<W [(#Q&3TY4(%-)6D4],CYT;&)W93PO
M1D].5#X-"@T*/$)2/B9N8G-P.R9N8G-P.R9N8G-P.R9N8G-P.R9N8G-P.R9N
M8G-P.R9N8G-P.R \1D].5"!325I%/3(^:7-Y;F,\+T9/3E0^#0H-"CQ"4CXF
M;F)S<#LF;F)S<#LF;F)S<#LF;F)S<#LF;F)S<#LF;F)S<#LF;F)S<#L@/$9/
M3E0@4TE:13TR/FQI)FYB<W [)FYB<W [)FYB<W [)FYB<W [)FYB<W [('(R
M+" P># P,64\+T9/3E0^#0H-"CQ"4CXF;F)S<#LF;F)S<#LF;F)S<#LF;F)S
M<#LF;F)S<#LF;F)S<#LF;F)S<#L@/$9/3E0@4TE:13TR/FUT<W!R)FYB<W [
M)FYB<W [($U-54-34C L('(R/"]&3TY4/@T*#0H\0E(^)FYB<W [)FYB<W [
M)FYB<W [)FYB<W [)FYB<W [)FYB<W [)FYB<W [(#Q&3TY4(%-)6D4],CYI
M<WEN8SPO1D].5#X-"@T*/$)2/CQ&3TY4(%-)6D4],CXC96YD:68\+T9/3E0^
M#0H\+U ^#0H-"CQ0/CQ&3TY4(%-)6D4],CY)('1H:6YK(&UY('!R;V)L96T@
M:7,@86QL(&-E;G1E<F5D(&%R;W5N9"!43$(G<R!A;F0@=&AE($-#4U)"05(N
M($D@9&]N)W0\+T9/3E0^#0H-"CQ"4CX\1D].5"!325I%/3(^:VYO=R!I9B!T
M:&4@86)O=F4@8V]D92!I<R!P87)T(&]F('1H92!P<F]B;&5M(&)U="!A="!R
M97-E="!T:&4@8W!U(&AA<SPO1D].5#X-"@T*/$)2/CQ&3TY4(%-)6D4],CYT
M:&4@0T-34D)!4B!A=" P>&9F-S P,# P(&%N9"!T:&5R92!I<R!A(%1,0B!E
M;G1R>2!M87!P960@=&\@:71S/"]&3TY4/@T*#0H\0E(^/$9/3E0@4TE:13TR
M/FQO8V%T:6]N+B!->2!I;FET(&-O9&4@:7,@;6]V:6YG('1H92!#0U-20D%2
M(&%N9"!M87!P:6YG(&$@5$Q"('1O(&ET<SPO1D].5#X-"@T*/$)2/CQ&3TY4
M(%-)6D4],CYN97<@;&]C871I;VXN($D@=')I960@:G5S="!M;W9I;F<@=&AE
M($-#4U)"05(@8F%C:R!T;R!I=',@9&5F875L=#PO1D].5#X-"@T*/$)2/CQ&
M3TY4(%-)6D4],CYL;V-A=&EO;BX@1&\@22!A;'-O(&YE960@=&\@<F5M87 @
M82!43$(@861D<F5S<R!T;R!D969A=6QT(&QO8V%T:6]N/R \+T9/3E0^#0H\
M+U ^#0H-"CQ0/CQ&3TY4(%-)6D4],CY4:&%N:W,L/"]&3TY4/@T*#0H\0E(^
M/$9/3E0@4TE:13TR/DUA='1H97<\+T9/3E0^#0H\+U ^#0H-"CQ0/CQ&3TY4
M(%-)6D4],CY$;V5S(&%N>6]N92!K;F]W('1H92!A;G-W97(@=&\@=&AI<R!P
M<F]B;&5M/SPO1D].5#X-"CPO4#X-"@T*/% ^/$9/3E0@4TE:13TR/G1H86YK
M<RP\+T9/3E0^#0H\+U ^#0H-"CQ0/CQ&3TY4(%-)6D4],CY&86AD/"]&3TY4
;/@T*/"]0/@T*#0H\+T)/1%D^#0H\+TA434P^
`
end


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
