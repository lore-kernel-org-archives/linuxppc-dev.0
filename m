Message-ID: <09f101c33546$1dd30f60$e600a8c0@udtech.net>
From: "Shen Rong" <rshen@udtech.com.cn>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: MPC75x Preformance Monitor Support
Date: Wed, 18 Jun 2003 11:02:55 +0800
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I have written a simple program which supports MPC75x cpu performance monitor.
It's really primitive. So I hope there is someone who has interesting and free time
to do further following work on it:
1. more features and more usable
2. config-able and module-able
3. check to see if it will conflict with other program using PMC, such as ppc_htab.c
4. write userland program to give out run-time curve, it's interesting
5. better than pmc_proc.c in iseries :-(
6. and finally, the most important is to be accepted by the ppc maintainers

Do I ask too much, if so, sorry.
Thanks.

Shenrong


begin 666 mpc75x_pmc.c
M+RH*("H@35!#-S5X(%!E<F9O<FUA;F-E($UO;FET;W(*("H*("H@4VAE;G)O
M;F<@/')S:&5N0'5D=&5C:"YC;VTN8VX^"B J"B J+PH*(VEN8VQU9&4@/&QI
M;G5X+V-O;F9I9RYH/@HC:6YC;'5D92 \;&EN=7@O<V-H960N:#X*(VEN8VQU
M9&4@/&QI;G5X+W!R;V-?9G,N:#X*(VEN8VQU9&4@/&QI;G5X+W-T870N:#X*
M(VEN8VQU9&4@/&QI;G5X+W-Y<V-T;"YH/@HC:6YC;'5D92 \;&EN=7@O8W1Y
M<&4N:#X*(VEN8VQU9&4@/&QI;G5X+VEN:70N:#X*"B-I;F-L=61E(#QA<VTO
M<')O8V5S<V]R+F@^"B-I;F-L=61E(#QA<VTO8W!U=&%B;&4N:#X*(VEN8VQU
M9&4@/&%S;2]S>7-T96TN:#X*"@HC9&5F:6YE($U-0U(P"0D).34R"B-D969I
M;F4@4$U#,0D)"3DU,PHC9&5F:6YE(%!#33()"0DY-30*(V1E9FEN92!324$)
M"0DY-34*(V1E9FEN92!-34-2,0D)"3DU-@HC9&5F:6YE(%!-0S,)"0DY-3<*
M(V1E9FEN92!034,T"0D).34X"@HC9&5F:6YE(%!-0S%?3#)(250)"3!X,#<*
M"B-D969I;F4@4$U#,E],,DE-25-3"0DP># W"B-D969I;F4@4$U#,E],,DPQ
M0T%35 D),'@P9 H*(V1E9FEN92!034,S7TPR1$U)4U,)"3!X,#<*(V1E9FEN
M92!034,S7TPR4TY/3U!#05-4"3!X,&,*(V1E9FEN92!034,S7TPQ2$E424Y,
M,@D),&,P9 H*(V1E9FEN92!034,T7TPR0T%310D),'@P-0H*(V1E9FEN92!0
M35]35%)?4TE:10D)-# Y-@H*"G-T871I8R!I;G0@<&U?;#)C86-H92AC=&Q?
M=&%B;&4@*F-T;"P@:6YT('=R:71E+"!S=')U8W0@9FEL92 J9FEL<"P@=F]I
M9" J8G5F9F5R+"!S:7IE7W0@*FQE;G I.PH*"G-T871I8R!C:&%R('!M7VEN
M9F];4$U?4U127U-)6D5=(#T@(EPP(CL*<W1A=&EC(&EN="!P;5]T:6UE(#T@
M-3L*"G-T871I8R!C=&Q?=&%B;&4@<&U?=&%B;&5;72 ]"GL*"7LQ+" B;#)C
M86-H92(L("9P;5]I;F9O+"!035]35%)?4TE:12P@,#0P,"P@3E5,3"P@)G!M
M7VPR8V%C:&5]+ H)>S(L(")P;5]T:6UE(BP@)G!M7W1I;64L('-I>F5O9BAI
M;G0I+" P-C P+"!.54Q,+" F<')O8U]D;VEN='9E8WTL"@E[,'T*?3L*"G-T
M871I8R!C=&Q?=&%B;&4@<&U?<F]O=%]T86)L95M=(#T*>PH)>S$L(")P;2(L
M($Y53$PL(# L(# U-34L('!M7W1A8FQE?2P*"7LP?0I].PH*<W1A=&EC('-T
M<G5C="!C=&Q?=&%B;&5?:&5A9&5R("IP;5]S>7-C=&Q?:&5A9&5R.PH*"G5N
M<VEG;F5D(&QO;F<@<F5A9%]M;6-R,"AV;VED*0I["@EU;G-I9VYE9"!L;VYG
M('9A;#L*"0H)87-M('9O;&%T:6QE*")M9G-P<B E,"P@.34R(B Z("(]<B(@
M*'9A;"DI.PH)<F5T=7)N('9A;#L*?0H*=6YS:6=N960@;&]N9R!R96%D7VUM
M8W(Q*'9O:60I"GL*"75N<VEG;F5D(&QO;F<@=F%L.PH)"@EA<VT@=F]L871I
M;&4H(FUF<W!R("4P+" Y-38B(#H@(CUR(B H=F%L*2D["@ER971U<FX@=F%L
M.PI]"@IV;VED(')E861?<&UC<RAU;G-I9VYE9"!L;VYG("IP,2P@=6YS:6=N
M960@;&]N9R J<#(L('5N<VEG;F5D(&QO;F<@*G S+"!U;G-I9VYE9"!L;VYG
M("IP-"D*>PH)=6YS:6=N960@;&]N9R!P;6,Q+"!P;6,R+"!P;6,S+"!P;6,T
M.PH*"6%S;2!V;VQA=&EL92 H"@D)(FUF<W!R("4P+" Y-3,@7&Y<="(*"0DB
M;69S<'(@)3$L(#DU-"!<;EQT(@H)"2)M9G-P<B E,BP@.34W(%QN7'0B"@D)
M(FUF<W!R("4S+" Y-3@@7&Y<="(*"0DZ("(]<B(@*'!M8S$I+" B/7(B("AP
M;6,R*2P@(CUR(B H<&UC,RDL("(]<B(@*'!M8S0I*3L*"@DJ<#$@/2!P;6,Q
M.PH)*G R(#T@<&UC,CL*"2IP,R ]('!M8S,["@DJ<#0@/2!P;6,T.PI]"@IV
M;VED(&-L96%R7W!M8W,H=F]I9"D*>PH)87-M('9O;&%T:6QE("@*"0DB;71S
M<'(@.34S+" E,"!<;EQT(@H)"2)M='-P<B Y-30L("4P(%QN7'0B"@D)(FUT
M<W!R(#DU-RP@)3 @7&Y<="()"0D@(" @"@D)(FUT<W!R(#DU."P@)3 @7&Y<
M="()"0D@(" @"@D).CH@(G(B("@P*2D["GT*"G9O:60@=W)I=&5?;6UC<C H
M=6YS:6=N960@;&]N9R!V86PI"GL*"6%S;2!V;VQA=&EL92@B;71S<'(@.34R
M+" E,"(@.CH@(G(B("AV86PI*3L*?0H*=F]I9"!W<FET95]M;6-R,2AU;G-I
M9VYE9"!L;VYG('9A;"D*>PH)87-M('9O;&%T:6QE*")M='-P<B Y-38L("4P
M(B Z.B B<B(@*'9A;"DI.PI]"@IV;VED('=R:71E7VUM8W)S*'5N<VEG;F5D
M(&QO;F<@=F%L,"P@=6YS:6=N960@;&]N9R!V86PQ*0I["@EA<VT@=F]L871I
M;&4H"@D)(FUT<W!R(#DU,BP@)3 @7')<;B(*"0DB;71S<'(@.34V+" E,2!<
M<EQN(@H)"3HZ(")R(B H=F%L,"DL(")R(B H=F%L,2DI.PI]"@II;G0@<&U?
M;#)C86-H92AC=&Q?=&%B;&4@*F-T;"P@:6YT('=R:71E+"!S=')U8W0@9FEL
M92 J9FEL<"P@=F]I9" J8G5F9F5R+"!S:7IE7W0@*FQE;G I"GL*"6EN="!R
M971V+"!P;W,@/2 P.PH)=6YS:6=N960@;&]N9R!P;6,Q+"!P;6,R+"!P;6,S
M+"!P;6,T.PH)=6YS:6=N960@;&]N9R!M;6-R,"P@;6UC<C$["@H):68@*"$J
M;&5N<"!\?" H9FEL<"T^9E]P;W,@)B8@(7=R:71E*2D@>PH)"2IL96YP(#T@
M,#L*"0ER971U<FX@,#L*"7T*"@EI9B H<&U?=&EM92 \/2 P*2!["@D)<&]S
M("L]('-P<FEN=&8H<&U?:6YF;R K('!O<RP@(G!M7W1I;64@:7,@;F]T('-E
M="P@<&QE87-E('-E="!I="!F:7)S=%QN(BD["@D)9V]T;R!F:6YA;#L*"7T*
M"@EW<FET95]M;6-R,"@Q(#P\(#,Q*3L)+RH@<W1O<"!034,@*B\*"6-L96%R
M7W!M8W,H*3L*"6UM8W(P(#T@*"A034,Q7TPR2$E4("8@,'@P,#=&*2 \/" V
M*2!\("A034,R7TPR24U)4U,@)B P># P,T8I.PH);6UC<C$@/2 H*%!-0S-?
M3#)$34E34R F(#!X,# Q1BD@/#P@,C<I('P@*"A034,T7TPR0T%312 F(#!X
M,# Q1BD@/#P@,C(I.PH*"7=R:71E7VUM8W)S*&UM8W(P+"!M;6-R,2D["2\J
M('-T87)T(%!-0R J+PH*"6-U<G)E;G0M/G-T871E(#T@5$%32U])3E1%4E)5
M4%1)0DQ%.PH)<V-H961U;&5?=&EM96]U="A(6B J('!M7W1I;64I.PH*"7=R
M:71E7VUM8W(P*#$@/#P@,S$I.PDO*B!S=&]P(%!-0R J+PH)<F5A9%]P;6-S
M*"9P;6,Q+" F<&UC,BP@)G!M8S,L("9P;6,T*3L*"@EP;W,@*ST@<W!R:6YT
M9BAP;5]I;F9O("L@<&]S+" B36]N:71O<B!F;W(@)60@<V5C;VYD<RP@34U#
M4C @/2 P>"4P.&QX($U-0U(Q(#T@,'@E,#AL>%QN(BP*"0D)<&U?=&EM92P@
M;6UC<C L(&UM8W(Q*3L*"0H)<&]S("L]('-P<FEN=&8H<&U?:6YF;R K('!O
M<RP@(B @("!.=6UB97(@;V8@86-C97-S97,@=&AA="!H:70@=&AE($PR.B E
M;'4E<UQN(BP@<&UC,2P*"0D)*'!M8S$@)B P>#@P,# P,# P*2 _("(H3RDB
M.B(B*3L*"7!O<R K/2!S<')I;G1F*'!M7VEN9F\@*R!P;W,L("(@(" @0V]U
M;G1S($PR(&EN<W1R=6-T:6]N(&UI<W-E<SH@(" @(" @)6QU)7-<;B(L('!M
M8S(L"@D)"2AP;6,R("8@,'@X,# P,# P,"D@/R B*$\I(CHB(BD["@EP;W,@
M*ST@<W!R:6YT9BAP;5]I;F9O("L@<&]S+" B(" @($YU;6)E<B!O9B!,,B!D
M871A(&UI<W-E<SH@(" @(" @(" @("5L=25S7&XB+"!P;6,S+ H)"0DH<&UC
M,R F(#!X.# P,# P,# I(#\@(BA/*2(Z(B(I.PH)<&]S("L]('-P<FEN=&8H
M<&U?:6YF;R K('!O<RP@(B @("!.=6UB97(@;V8@3#(@8V%S=&]U=',Z(" @
M(" @(" @(" @(" E;'4E<UQN(BP@<&UC-"P*"0D)*'!M8S0@)B P>#@P,# P
M,# P*2 _("(H3RDB.B(B*3L*"0IF:6YA;#H*"2IL96YP(#T@<&]S.PH)<F5T
M=B ]('!R;V-?9&]S=')I;F<H8W1L+"!W<FET92P@9FEL<"P@8G5F9F5R+"!L
M96YP*3L*"7)E='5R;B!R971V.PI]"@IS=&%T:6,@:6YT(%]?:6YI="!M<&,W
M-7A?<&U?:6YI="AV;VED*0I["@EP;5]S>7-C=&Q?:&5A9&5R(#T@<F5G:7-T
M97)?<WES8W1L7W1A8FQE*'!M7W)O;W1?=&%B;&4L(# I.PH)<F5T=7)N(# [
M"GT*"G9O:60@;7!C-S5X7W!M7W)E;&5A<V4H=F]I9"D*>PH):68H<&U?<WES
M8W1L7VAE861E<BD*"0EU;G)E9VES=&5R7W-Y<V-T;%]T86)L92AP;5]S>7-C
K=&Q?:&5A9&5R*3L*?0H*7U]I;FET8V%L;"AM<&,W-7A?<&U?:6YI="D["@``
`
end


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
