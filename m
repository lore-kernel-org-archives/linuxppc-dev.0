Message-ID: <4118282C375DF64EA700135193EEB8CAB0020F@ACUSH02>
From: "Dixon, Myron @ GNS" <Myron.Dixon@L-3com.com>
To: miguel.valero@axxessit.no, linuxppc-embedded@lists.linuxppc.org
Subject: RE: DS1340 RTC (i2c device)
Date: Mon, 19 Jul 2004 10:18:28 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have done this with a ds1337.  I found the solution on this mailing list.
I think it was Wolfgang who had implemented the solution.  Essentially,
the technique is to do as you suggest, replace your unique driver functions
with the predefined ones being pointed to by the ppc_md structure.

Worked great for me on our 8260 custom board using a 2.4.18 kernel.

Just search the archives for rtc fixes.

Myron

-----Original Message-----
From: miguel.valero@axxessit.no [mailto:miguel.valero@axxessit.no]
Sent: Monday, 19 July, 2004 2:44 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: DS1340 RTC (i2c device)



Does anyone have any good suggestions about how to handle an i2c RTC
device, as f.e. the Maxim ds1340 ?

As far as I can understand, the "todc_time" component only supports memory
mapped RTC devices.

I believe I have to implement my own, platform dependent, "time_init",
"set_rtc_time" and "get_rtc_time" functions, and register them in the
ppc_md structure during platform initialisation.

I also believe that "time_init" and "get_rtc_time" are called by the
kernel rather early.

The question is whether the i2c driver is already in place by the time
these functions are called, so that I can register a driver for the
ds1340.
Has anyone done something like that ?
If I am on the wrong track, can someone give me a good hint ?

Regards
Miguel A. Valero
R & D Engineer
----------------------------------------------------------------------------
--------------------------
AXXESSIT ASA
PB 219 Økern
Risløkkveien 2 N-0510 Oslo
----------------------------------------------------------------------------
--------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
