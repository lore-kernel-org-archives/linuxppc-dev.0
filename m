From: NBLIST@sbcglobal.net
To: "John W. Linville" <linville@lvl7.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-Id: <AA-88FBB7BCDA80FF9197A0661F6F3F5E28-ZZ@www4.prodigy.net>
Date: Thu, 23 May 2002 17:00:57 -0500
Subject: ethernet works only the first time :- Fixed
MIME-Version: 1.0
Content-Type: multipart/mixed;
    boundary="AA-C56B3FBA3BEBC0CC910D94262FB385F8-ZZ"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.

--AA-C56B3FBA3BEBC0CC910D94262FB385F8-ZZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello all,

I noticed that
               ifconfig eth0 up
calls fec_open() and
               ifconfig eth0 down
calls fec_close().

But fec_close() makes a call to fec_stop() which shuts
down the fec controller. fec_open() does not re-
initialize the controller again. And so, the ethernet
interface never works the second time around. Works
the first time since fec_init has set up init.

The fix is to remove the call to fec_stop() in
fec_close(). I've attached a patch that should work on
the MVista kernel 2.4.0 fec driver. An appropriate
location to call fec_stop() would be in cleanup_module
if the fec driver was a loadable kernel module.

Thank you,
Navin Boppuri.

--AA-C56B3FBA3BEBC0CC910D94262FB385F8-ZZ
Content-Type: text/plain;
    name="fec.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
    filename="fec.patch"

KioqIG9sZGZlYy5jCVRodSBNYXkgMjMgMTU6MTU6MjcgMjAwMgotLS0gZmVjLmMJVGh1IE1h
eSAyMyAxNToyNjo0NiAyMDAyCioqKioqKioqKioqKioqKgoqKiogMTQ0NCwxNDUyICoqKioK
ICB7CiAgCS8qIERvbid0IGtub3cgd2hhdCB0byBkbyB5ZXQuCiAgCSovCiAgCW5ldGlmX3N0
b3BfcXVldWUoZGV2KTsKLSAJZmVjX3N0b3AoZGV2KTsKICAKICAJcmV0dXJuIDA7CiAgfQog
IAotLS0gMTQ0NCwxNDUxIC0tLS0K

--AA-C56B3FBA3BEBC0CC910D94262FB385F8-ZZ--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
