Message-ID: <19990225113953.9356.rocketmail@send203.yahoomail.com>
Date: Thu, 25 Feb 1999 03:39:53 -0800 (PST)
From: "D.J. Barrow" <barrow_dj@yahoo.com>
Subject: signal handling bug demo....
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>,
        Gary Thomas <gdt@linuxppc.org>, Lauro Whately <whately@cos.ufrj.br>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-2145174067-919942793=:21848"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--0-2145174067-919942793=:21848
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Here is a demonstration of the bug I described in earlier mails about signals being lost by the kernel.
I am now quite sure the bug will manifest itself in all variants of linux unless the signal dispatching has changed radically. The code is I believe posix compilant ( Thanks Lauro ).

The bug arises when (sig)longjmp gets called out of a signal handler sys_sigreturn dosen't get called & the signals queued on the user stack get trashed.


To Demo:
put parent.c child.c & testmake in the same
directory. Compile using testmake  run parent.
Note "the bug" that only one signal gets delivered per loop of the child.

This bug I believe can be fixed by simplifing the kernel. There is no reason  (I'm aware of ) to queue the signals on the user stack sys_sigreturn gets called in the kernel for every signal delivered so this queueing is fundamentally a braindamaged idea.


The bug can be fixed I believe by
1) Removeing the while loop in do signal 
2) Removing the current sys_sigreturn
3) Making do_signal also function as sys_sigreturn.
4) Remove handle_signal.
5) Unblock the signal before delivering it ( this would enable longjmp out of signal handlers to behave correctly also ) rather than leaving the signal blocked forever.

So no do_signal will get called for each signal delivered. The thing would be a lot stabiler & use less userstack & remove -200 lines of really crap code.





_________________________________________________________
DO YOU YAHOO!?
Get your free @yahoo.com address at http://mail.yahoo.com

--0-2145174067-919942793=:21848
Content-Type: application/octet-stream; name="child.c"
Content-Description: child.c
Content-Disposition: attachment; filename="child.c"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzaWduYWwuaD4KI2luY2x1
ZGUgPHNldGptcC5oPgoKaW50IG1haW4oaW50IGFyZ2MsY2hhciAqYXJndltd
KQp7CiAgIGludCBjbnQ7CiAgIHByaW50ZigiSW4gY2hpbGRcbiIpOwogICBm
b3IoY250PTA7Y250PDMwO2NudCsrKQogICB7CiAgICAgIHByaW50ZigibG9v
cGluZyBpbiBjaGlsZFxuIik7CiAgICAgIGtpbGwoZ2V0cHBpZCgpLFNJR1VT
UjEpOwogICAgICBraWxsKGdldHBwaWQoKSxTSUdVU1IyKTsKICAgICAgc2xl
ZXAoMSk7CiAgIH0KfQo=

--0-2145174067-919942793=:21848
Content-Type: application/octet-stream; name="parent.c"
Content-Description: parent.c
Content-Disposition: attachment; filename="parent.c"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzaWduYWwuaD4KI2luY2x1
ZGUgPHNldGptcC5oPgoKc2lnam1wX2J1ZiBnZW52OwoKdm9pZCBteXNpZ25h
bChpbnQgc2lnKQp7CiAgcHJpbnRmKCJyZWNlaXZlZCBzaWduYWwgJWRcbiIs
c2lnKTsKICBzaWdsb25nam1wKGdlbnYsMSk7Cn0KCgppbnQgbWFpbihpbnQg
YXJnYyxjaGFyICphcmd2W10pCnsKICBpbnQgY2hpbGRwaWQ7CgogIHNpZ25h
bChTSUdVU1IxLG15c2lnbmFsKTsKICBzaWduYWwoU0lHVVNSMixteXNpZ25h
bCk7CiAgaWYoKGNoaWxkcGlkPWZvcmsoKSk9PS0xKQogIHsKICAgICAgcHJp
bnRmKCJmb3JrIGZhaWxlZFxuIik7CiAgICAgIGV4aXQoLTEpOwogIH0KICBl
bHNlIGlmKGNoaWxkcGlkPT0wKQogIHsKICAgICAgcHJpbnRmKCJleGVjbHBp
bmcgY2hpbGQgcGlkPSVkIixnZXRwaWQoKSk7CiAgICAgIGlmKGV4ZWNscCgi
Li9jaGlsZCIsIi4vY2hpbGQiLChjaGFyICopMCk9PS0xKQogICAgICB7Cgkg
cHJpbnRmKCJleGVjbHAgZmFpbGVkIik7CgkgZXhpdCgtMSk7CiAgICAgIH0K
ICB9CiAgc2lnc2V0am1wKGdlbnYsMSk7CiAgZm9yKDs7KQogIHsKICAgIHBy
aW50ZigibG9vcGluZyBpbiBwYXJlbnRcbiIpOwogICAgc2xlZXAoMSk7CiAg
fQp9Cg==

--0-2145174067-919942793=:21848
Content-Type: application/octet-stream; name=testmake
Content-Description: testmake
Content-Disposition: attachment; filename=testmake
Content-Transfer-Encoding: base64

Z2NjIC1EX19VU0VfQlNEX1NJR05BTCAtRF9fVVNFX0JTRCBjaGlsZC5jIC1v
IGNoaWxkCmdjYyAtRF9fVVNFX0JTRF9TSUdOQUwgLURfX1VTRV9CU0QgIHBh
cmVudC5jIC1vIHBhcmVudAo=

--0-2145174067-919942793=:21848--

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
