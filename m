Message-Id: <200002251437.IAA05384@lists.linuxppc.org>
Date: Fri, 25 Feb 2000 09:36:11 -0500 (EST)
From: Kevin_Hendricks <khendricks@admin.ivey.uwo.ca>
Reply-To: Kevin_Hendricks <khendricks@admin.ivey.uwo.ca>
Subject: Re: patch to get latest XFree 4.0 snapshot (xf3918) to work on ppc with r128
To: khendricks@ivey.uwo.ca, gewrgiou@imbc.gr
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY=Husk_of_Hares_367_000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--Husk_of_Hares_367_000
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: aNL2T5tzH0G5L65+PzIKnw==

Hi,

>  There were some changes recently in the mouse module in xfree, some PS/2
>mice were broken for a while but that has been fixed before 3.9.18, I don't
>a usb mouse at my mac so i can't help there but IMPS/2 works fine in my x86
>machine.

>From looking at mouse.c, either x86 IMPS/2 is very different from that used in
ppc or something else is messed up.

Here is the problem pieces of code:

First are the protocol parameters for IMPS2 which map to the IntelliMouse:


  {  0x08, 0x08, 0x00, 0x00,  4,   0x00, 0xff, MPF_NONE },  /* IntelliMouse */



Then in MouseReadInput() there is a check to see if the packet looks reasonable
to determine if things have gotten out of sync.

        /* Accept or reject the packet ? */
        if ((pBuf[0] & pMse->protoPara[0]) != pMse->protoPara[1] || baddata) {
#ifdef EXTMOUSEDEBUG
            if (pMse->inSync)
                ErrorF("mouse driver lost sync\n");
            ErrorF("skipping byte %02x\n",*pBuf);
#endif
            pMse->protoBufTail = --pBufP;
            for (j = 0; j < pBufP; j++)
                pBuf[j] = pBuf[j+1];
            pMse->inSync = 0;
            continue;
        }


But according to my specs on IMPS/2 the first character has the following binary
format:

0b00xy0321  with xy indicating movement in positive x or y direction of mouse
and 321 being the mouse buttons.  The later characters determine the dx, dy, and
dz values.

but the test for out of sync:

        if ((pBuf[0] & pMse->protoPara[0]) != pMse->protoPara[1] || baddata) {

             0b00xy0321 & 0x8 !=  0x8

This will result in deliberately throwing out the the current pBuf[0] since on a
good first character they can never be equal.

This was resulting in out of sync conditions completely since we were throwing
out perfectly good characters until we got one that randomly fit the sync
test!!!

I checked 3.9.17 and the values for the protocol parameters were in fact
different:

Here are the old ones:

  {  0xc0, 0x00, 0x00, 0x00,  4,   0x00, 0xff, MPF_NONE },  /* IntelliMouse */

These would work for my IMPS/2 mouse.

So because someone wanted this to work with their mouse (which has two extra
buttons) they had to change the first parameter from 0xc0 to 0x8 (because their
protocal mapped buttons 4 and 5 into those first two bits) but for some reason
they wanted or needed to always throw out the first character and then changed
the second parameter from 0x00 to 0x08.

This is simply not correct.  The IMPS/2 protocol I have seen does not have
buttons 4 and 5 and does not throw out one bad character at the beginning.

I have changed mouse.c to remove the "extra" buttons 4 and 5 and changed to the
correct out of sync parameter masks: { 0xc8, 0x00 ... and now it works fine with
3 or 4 bytes being read (the value for dz is optional).


So someone kludged it to work for their mouse and broke it for everyone else.

If IMPS/2 (nonserial) does indeed work on your x86 machine then something has
defintely changed!

I have attached my mouse.c patch and now finally with this patch in place,
everything is working on xf 3.9.18

The patch is attached:


Will you check this with your IMPS/2 (assuming it is non-serial since the IMPS/2
serial mice use a different code)?  If it works, please consider forwarding this
to the xfree lists for possible inclusion for xf 4.0.

Thanks,

Kevin

--
Kevin B. Hendricks
Associate Professor of Operations and Information Technology
Richard Ivey School of Business, University of Western Ontario
London, Ontario  N6A-3K7  CANADA
khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959

--Husk_of_Hares_367_000
Content-Type: APPLICATION/octet-stream; name="mouse_chg.patch.gz"; x-unix-mode=0666
Content-Description: mouse_chg.patch.gz
Content-MD5: OROCz+yvApixhVs39LjzrA==
Content-Transfer-Encoding: BASE64

H4sICPyRtjgAA21vdXNlX2NoZy5wYXRjaAClkv9P4jAYxn+Gv+JJTC7iNuk6
BnN6inqQXCJIlN8uxkzopBEHGcNw3/7367fBnBg012Tt2ref533avo7j4Hm2
XLDD0eE8ZS+VbsrRZQ+gPshRSFuh3wIlhFQty8p3ljZ5JCSe3tRuw/GbLbsF
Sw/tdhXAb4CsAmKXeiJ6eOIz/2QVxzZ6g+59/7rfwV8RqR/g/LJzef4NB/Uq
KroJQAYGt3WKlyjlUZItVNxkGq3Vi/3uTEpQnVGqOUaNBPam36g1dql9TzI2
nfJermfl7oKt7j6th//011nNp7OUpUWt8ut89OaGE5488eTxo+Z2CiqhXpRY
UkxWlUubgX0ES42upwqrMopEtsHN9fC+3xkObmlYEWifZdqGek5VNrJgHpZZ
NksW+Ir9+cUy/kHu8EVaaNRwegoXf6CbTM7H4ykzFadXXzP0LXPDHyeZeubt
iFvDyQnoMTbIFYs1UbX2eAzyXjaDFrPl6HaiQZQ/r0jo46PxPhUYqmjRUL6y
uceSMY/NdY5X5Zt0BX8mQ2rRvXOo3wTC9fw4J3+WSapJRy9SRdYE6Zj5mvwl
ydEkSmsq4onIP7RFHP3BBAAA

--Husk_of_Hares_367_000--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
