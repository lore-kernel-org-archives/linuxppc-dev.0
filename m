Message-ID: <E1836A7F3557D311A14000805F9F36FC0141C859@usdfo011.usac.danfoss.net>
From: Hihn Jason <JasonHihn@DANFOSS.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Connecting an Optrex display
Date: Fri, 23 Aug 2002 17:31:24 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am trying to get an Optrex display working in an 823e. (DMF-50840)
It's a 320x240 passive monochrome, with a parallel 4 bit interface.
I'm close to having it working, but I can't seem to get it 100%

I try to put out a pattern of
*-*-*-*-*-*-... (AA)
-*-*-*-*-*-*... (55)
[repeat]

but what's displayed is:
123456789ABC
*--**--**--*...
*--**--**--*...
-*-*-*-*-*-*...
-*-*-*-*-*-*...
[repeats]

Note how columns 3,7,B are always 0, and 4,8,C are always one.
I have the panel configed as :
static vidinfo_t panel_info = {
 /* W(p), H(p), W(mm), H(mm) */
    320,  240,  120,   90,

 /* CLK POL,  OUT_EN,   HSYNC POL, VSYN POL, DATA POL */
    CFG_HIGH, CFG_HIGH, CFG_HIGH,  CFG_HIGH, CFG_LOW,

    /*BPP 2^X */ 0, /*BUSWID=4*/ 0, /*SINGLE=YES*/ 1, /*COLOR=NO*/ 0,
    /*TFT=NO*/ 0,   /*WBL*/ 5,      /*VSPW=NA*/ 0, /*AC*/ 16, /*WBF*/ 0
};

I have to admit I have no idea on what Wait Between Lines and Wait Between
frames should be set to, or how to derive them.

Any help would be appreciated.
-Jason

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
