Date: Wed, 5 Dec 2001 00:24:57 -0300
From: Ricardo Scop <scop@digitel.com.br>
Reply-To: scop@digitel.com.br
Message-ID: <917.011205@digitel.com.br>
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org, andy_lowe@mvista.com
Subject: Re[2]: Kernel oops while routing
In-reply-To: <3C06B9D0.7020804@embeddededge.com>
References: <3C06B9D0.7020804@embeddededge.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----------B41A81AF368DCFE8"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


------------B41A81AF368DCFE8
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Dan,

I apologize for the delay. We were conducting some more tests so as to
not make any more false alarms :-) about kernel crashes, memory leaks
and/or performance problems in the linuxppc port to our 8255 hardware
platform.

So, after a _carefull_ test period, these are our findings:

1 - Andy's patch (which is attached) works well and does _not_
append any performance penalties in our tests (we were having PHY
negatiation problems there, again :-/ ).

2 - We _did_ have a memory leak which was causing a kernel crash after
a while, and it _was_ solved by Andy's patch (thanks, Andy!). I believe
it's still on linuxppc_2_4, _2_4_devel and _2_5. It goes like this:

     - in fcc_enet_start_xmit, after setting up another bd and
     incrementing bdp, the next bd's tx-ready bit is tested in order
     to stop the xmit queue if it is set, ok? But, sometimes, the CPM
     may already have cleared this bit _and_ the corresponding
     interrupt has not been serviced yet (because we're in a
     spin_lock_irq); so, netif_stop_queue is not called in this case,
     nor is tx_full set;

     - next, the interrupt is serviced, but then curr_tx equals
     dirty_tx _and_ tx_full is not set, so no sk_buffers are freed!

     - next time fcc_enet_start_xmit is called, tx_ready bit is still
     cleared and the next bd is used, but the corresponding sk_buffer
     wasn't freed, and it's pointer is now lost;

     - cep->lock can't help with this problem, because the CPM is not
     bothered by that 8-). AFAIK, Andy's solution is a good one.

So, we're offering this patch to the public list (with Andy's
blessing :-). I can provide any other details about our tests, if
required.

Thenks,

Ricardo Scop                            mailto:scop@vanet.com.br
R SCOP Consulting

------------------------------------------------------------------
"What's money? A man is a success if he gets up in the morning and
goes to bed at night and in between does what he wants to do."
~Bob Dylan

Thursday, November 29, 2001, 7:42:24 PM, you wrote:

DM> Ricardo Scop wrote:


>> I'm kind of lost with this performance variations. As far as I could
>> see, the patch did not insert much processing overhead, so...

DM> Perhaps if someone would post the patch for the rest of us to see we
DM> could be of some assistance.


DM>         -- Dan

------------B41A81AF368DCFE8
Content-Type: application/octet-stream; name="patch-2.41.16-pre1-fcc_enet"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="patch-2.41.16-pre1-fcc_enet"

SW5kZXg6IGFyY2gvcHBjLzgyNjBfaW8vZmNjX2VuZXQuYwo9PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09ClJDUyBmaWxlOiAv
dmFyL2N2cy9rZXJuZWwvYXJjaC9wcGMvODI2MF9pby9mY2NfZW5ldC5jLHYKcmV0cmlldmluZyBy
ZXZpc2lvbiAxLjEuMS4xLjQuMgpkaWZmIC11IC1yMS4xLjEuMS40LjIgZmNjX2VuZXQuYwotLS0g
YXJjaC9wcGMvODI2MF9pby9mY2NfZW5ldC5jCTQgU2VwIDIwMDEgMTY6Mzc6MTggLTAwMDAJMS4x
LjEuMS40LjIKKysrIGFyY2gvcHBjLzgyNjBfaW8vZmNjX2VuZXQuYwkyNyBOb3YgMjAwMSAxODo0
Mjo0MyAtMDAwMApAQCAtMzAwLDcgKzMwMCw3IEBACiAJdm9sYXRpbGUgZmNjX3QJKmZjY3A7CiAJ
dm9sYXRpbGUgZmNjX2VuZXRfdAkqZXA7CiAJc3RydWN0CW5ldF9kZXZpY2Vfc3RhdHMgc3RhdHM7
Ci0JdWludAl0eF9mdWxsOworCXVpbnQJdHhfZnJlZTsKIAlzcGlubG9ja190IGxvY2s7CiAKICNp
ZmRlZglDT05GSUdfVVNFX01ESU8KQEAgLTM2MCw5ICszNjAsOSBAQAogCWJkcCA9IGNlcC0+Y3Vy
X3R4OwogCiAjaWZuZGVmIGZpbmFsX3ZlcnNpb24KLQlpZiAoYmRwLT5jYmRfc2MgJiBCRF9FTkVU
X1RYX1JFQURZKSB7CisJaWYgKCFjZXAtPnR4X2ZyZWUgfHwgKGJkcC0+Y2JkX3NjICYgQkRfRU5F
VF9UWF9SRUFEWSkpIHsKIAkJLyogT29vcHMuICBBbGwgdHJhbnNtaXQgYnVmZmVycyBhcmUgZnVs
bC4gIEJhaWwgb3V0LgotCQkgKiBUaGlzIHNob3VsZCBub3QgaGFwcGVuLCBzaW5jZSBjZXAtPnR4
X2Z1bGwgc2hvdWxkIGJlIHNldC4KKwkJICogVGhpcyBzaG91bGQgbm90IGhhcHBlbiwgc2luY2Ug
dGhlIHR4IHF1ZXVlIHNob3VsZCBiZSBzdG9wcGVkLgogCQkgKi8KIAkJcHJpbnRrKCIlczogdHgg
cXVldWUgZnVsbCEuXG4iLCBkZXYtPm5hbWUpOwogCQlyZXR1cm4gMTsKQEAgLTQwNywxMCArNDA3
LDggQEAKIAllbHNlCiAJCWJkcCsrOwogCi0JaWYgKGJkcC0+Y2JkX3NjICYgQkRfRU5FVF9UWF9S
RUFEWSkgeworCWlmICghLS1jZXAtPnR4X2ZyZWUpCiAJCW5ldGlmX3N0b3BfcXVldWUoZGV2KTsK
LQkJY2VwLT50eF9mdWxsID0gMTsKLQl9CiAKIAljZXAtPmN1cl90eCA9IChjYmRfdCAqKWJkcDsK
IApAQCAtNDMxLDggKzQyOSw4IEBACiAJewogCQlpbnQJaTsKIAkJY2JkX3QJKmJkcDsKLQkJcHJp
bnRrKCIgUmluZyBkYXRhIGR1bXA6IGN1cl90eCAlcCVzIGN1cl9yeCAlcC5cbiIsCi0JCSAgICAg
ICBjZXAtPmN1cl90eCwgY2VwLT50eF9mdWxsID8gIiAoZnVsbCkiIDogIiIsCisJCXByaW50aygi
IFJpbmcgZGF0YSBkdW1wOiBjdXJfdHggJXAgdHhfZnJlZSAlZCBjdXJfcnggJXAuXG4iLAorCQkg
ICAgICAgY2VwLT5jdXJfdHgsIGNlcC0+dHhfZnJlZSwKIAkJICAgICAgIGNlcC0+Y3VyX3J4KTsK
IAkJYmRwID0gY2VwLT50eF9iZF9iYXNlOwogCQlwcmludGsoIiBUeCBAYmFzZSAlcCA6XG4iLCBi
ZHApOwpAQCAtNDUwLDcgKzQ0OCw3IEBACiAJCQkgICAgICAgYmRwLT5jYmRfYnVmYWRkcik7CiAJ
fQogI2VuZGlmCi0JaWYgKCFjZXAtPnR4X2Z1bGwpCisJaWYgKGNlcC0+dHhfZnJlZSkKIAkJbmV0
aWZfd2FrZV9xdWV1ZShkZXYpOwogfQogCkBAIC00OTIsNyArNDkwLDcgQEAKIAkgICAgc3Bpbl9s
b2NrKCZjZXAtPmxvY2spOwogCSAgICBiZHAgPSBjZXAtPmRpcnR5X3R4OwogCSAgICB3aGlsZSAo
KGJkcC0+Y2JkX3NjJkJEX0VORVRfVFhfUkVBRFkpPT0wKSB7Ci0JCWlmICgoYmRwPT1jZXAtPmN1
cl90eCkgJiYgKGNlcC0+dHhfZnVsbCA9PSAwKSkKKwkJaWYgKGNlcC0+dHhfZnJlZSA9PSBUWF9S
SU5HX1NJWkUpCiAJCSAgICBicmVhazsKIAogCQlpZiAoYmRwLT5jYmRfc2MgJiBCRF9FTkVUX1RY
X0hCKQkvKiBObyBoZWFydGJlYXQgKi8KQEAgLTU0Niw4ICs1NDQsNyBAQAogCQkvKiBTaW5jZSB3
ZSBoYXZlIGZyZWVkIHVwIGEgYnVmZmVyLCB0aGUgcmluZyBpcyBubyBsb25nZXIKIAkJICogZnVs
bC4KIAkJICovCi0JCWlmIChjZXAtPnR4X2Z1bGwpIHsKLQkJCWNlcC0+dHhfZnVsbCA9IDA7CisJ
CWlmICghY2VwLT50eF9mcmVlKyspIHsKIAkJCWlmIChuZXRpZl9xdWV1ZV9zdG9wcGVkKGRldikp
IHsKIAkJCQluZXRpZl93YWtlX3F1ZXVlKGRldik7CiAJCQl9CkBAIC0xNTI5LDYgKzE1MjYsNyBA
QAogI2VuZGlmCiAKIAljZXAtPmRpcnR5X3R4ID0gY2VwLT5jdXJfdHggPSBjZXAtPnR4X2JkX2Jh
c2U7CisJY2VwLT50eF9mcmVlID0gVFhfUklOR19TSVpFOwogCWNlcC0+Y3VyX3J4ID0gY2VwLT5y
eF9iZF9iYXNlOwogCiAJZXAtPmZlbl9nZW5mY2MuZmNjX3JzdGF0ZSA9IChDUE1GQ1JfR0JMIHwg
Q1BNRkNSX0VCKSA8PCAyNDsKDQoNCg==
------------B41A81AF368DCFE8--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
