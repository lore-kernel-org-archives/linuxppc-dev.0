Return-Path: <SRS0=xcTM=U5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,HTML_MIME_NO_HTML_TAG,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_ONLY,MISSING_MIMEOLE,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942EDC5B576
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Jun 2019 04:30:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC67A2089C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Jun 2019 04:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org; dmarc=permerror header.from=scram.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45byGV0MrVzDqsC
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Jun 2019 14:30:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=scram.de
 (client-ip=2a01:4f8:130:2201::3; helo=mail.scram.de;
 envelope-from=jochen@scram.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=permerror header.from=scram.de
X-Greylist: delayed 178 seconds by postgrey-1.36 at bilbo;
 Sat, 29 Jun 2019 21:44:28 AEST
Received: from mail.scram.de (mail0.scram.de [IPv6:2a01:4f8:130:2201::3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45bWy42pRPzDqcc
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jun 2019 21:44:26 +1000 (AEST)
Received: from localhost (mail0.scram.de [78.47.204.202])
 by localhost (Postfix) with ESMTP id 0BC5256D91;
 Sat, 29 Jun 2019 13:41:17 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at scram.de
Received: from mail.scram.de ([78.47.204.202])
 by localhost (mail.scram.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PW2IwdcdJtpO; Sat, 29 Jun 2019 13:41:04 +0200 (CEST)
Received: (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client did not present a certificate) (Authenticated sender)
 by mail.scram.de (Postfix) with ESMTPSA id 0752F551A6;
 Sat, 29 Jun 2019 13:41:03 +0200 (CEST)
Date: Sat, 29 Jun 2019 13:41:02 +0200
Subject: Re: [PATCH] i2c: remove casting dma_alloc
Message-ID: <7ae3d130-b835-4966-b21d-3ad7dac86046@email.android.com>
X-Android-Message-ID: <7ae3d130-b835-4966-b21d-3ad7dac86046@email.android.com>
In-Reply-To: <20190629113424.GH1685@kunai>
From: Jochen Friedrich <jochen@scram.de>
To: Wolfram Sang <wsa@the-dreams.de>
Importance: Normal
X-Priority: 3
X-MSMail-Priority: Normal
MIME-Version: 1.0
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: base64
X-Mailman-Approved-At: Sun, 30 Jun 2019 14:28:43 +1000
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Vasyl Gomonovych <gomonovych@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

PGRpdiBkaXI9J2F1dG8nPkhpIFdvbGZyYW0sPGRpdiBkaXI9ImF1dG8iPjxicj48L2Rpdj48ZGl2
IGRpcj0iYXV0byI+eWVzLCBJJ20gc3RpbGwgaGVyZS4gSG93ZXZlciwgSSBkb24ndCBoYXZlIHRo
ZSBoYXJkd2FyZSBhbnltb3JlIHRvIHRlc3QgdGhlIHBhdGNoLjwvZGl2PjxkaXYgZGlyPSJhdXRv
Ij48YnI+PC9kaXY+PGRpdiBkaXI9ImF1dG8iPlRoYW5rcywgSm9jaGVuJm5ic3A7PC9kaXY+PC9k
aXY+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+
QW0gMjkuMDYuMjAxOSAxMzozNCBzY2hyaWViIFdvbGZyYW0gU2FuZyAmbHQ7d3NhQHRoZS1kcmVh
bXMuZGUmZ3Q7OjxiciB0eXBlPSJhdHRyaWJ1dGlvbiIgLz48YmxvY2txdW90ZSBjbGFzcz0icXVv
dGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtw
YWRkaW5nLWxlZnQ6MWV4Ij48cCBkaXI9Imx0ciI+T24gU3VuLCBKdW4gMjMsIDIwMTkgYXQgMTE6
MTM6NTNQTSArMDIwMCwgVmFzeWwgR29tb25vdnljaCB3cm90ZTomIzEzOzxicj4KJmd0OyBGcm9t
OiBWYXN5bCAmbHQ7Z29tb25vdnljaEBnbWFpbC5jb20mZ3Q7JiMxMzs8YnI+CiZndDsgJiMxMzs8
YnI+CiZndDsgR2VuZXJhdGVkIGJ5OiZuYnNwOyBhbGxvY19jYXN0LmNvY2NpJiMxMzs8YnI+CiZn
dDsgJiMxMzs8YnI+CiZndDsgU2lnbmVkLW9mZi1ieTogVmFzeWwgJmx0O2dvbW9ub3Z5Y2hAZ21h
aWwuY29tJmd0OyYjMTM7PGJyPgomIzEzOzxicj4KWW91ciBvdGhlciBwYXRjaGVzIGluIGdpdCBo
aXN0b3J5IGhhdmUgeW91ciBmdWxsIG5hbWUuIFdoeSBub3QgdGhpcyBvbmU/JiMxMzs8YnI+CiYj
MTM7PGJyPgpASm9jaGVuOiBhcmUgeW91IHN0aWxsIHRoZXJlLCB5b3VyIGFjayB3b3VsZCBiZSB2
ZXJ5IHdlbGNvbWUuJiMxMzs8YnI+CiYjMTM7PGJyPgomZ3Q7IC0tLSYjMTM7PGJyPgomZ3Q7Jm5i
c3A7IGRyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtY3BtLmMgfCA0ICsrKy0mIzEzOzxicj4KJmd0OyZu
YnNwOyAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pJiMxMzs8
YnI+CiZndDsgJiMxMzs8YnI+CiZndDsgZGlmZiAtLWdpdCBhL2RyaXZlcnMvaTJjL2J1c3Nlcy9p
MmMtY3BtLmMgYi9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLWNwbS5jJiMxMzs8YnI+CiZndDsgaW5k
ZXggMTg3OTAwNTk0ZTNkLi4xMjEzZTE5MzJjY2IgMTAwNjQ0JiMxMzs8YnI+CiZndDsgLS0tIGEv
ZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1jcG0uYyYjMTM7PGJyPgomZ3Q7ICsrKyBiL2RyaXZlcnMv
aTJjL2J1c3Nlcy9pMmMtY3BtLmMmIzEzOzxicj4KJmd0OyBAQCAtNTMxLDcgKzUzMSw5IEBAIHN0
YXRpYyBpbnQgY3BtX2kyY19zZXR1cChzdHJ1Y3QgY3BtX2kyYyAqY3BtKSYjMTM7PGJyPgomZ3Q7
Jm5ic3A7ICYjOTsmIzk7fSYjMTM7PGJyPgomZ3Q7Jm5ic3A7ICYjOTsmIzk7b3V0X2JlMzIoJmFt
cDtyYmRmW2ldLmNiZF9idWZhZGRyLCAoKGNwbS0mZ3Q7cnhkbWFbaV0gKyAxKSAmYW1wOyB+MSkp
OyYjMTM7PGJyPgomZ3Q7Jm5ic3A7ICYjMTM7PGJyPgomZ3Q7IC0mIzk7JiM5O2NwbS0mZ3Q7dHhi
dWZbaV0gPSAodW5zaWduZWQgY2hhciAqKWRtYV9hbGxvY19jb2hlcmVudCgmYW1wO2NwbS0mZ3Q7
b2ZkZXYtJmd0O2RldiwgQ1BNX01BWF9SRUFEICsgMSwgJmFtcDtjcG0tJmd0O3R4ZG1hW2ldLCBH
RlBfS0VSTkVMKTsmIzEzOzxicj4KJmd0OyArJiM5OyYjOTtjcG0tJmd0O3R4YnVmW2ldID0gZG1h
X2FsbG9jX2NvaGVyZW50KCZhbXA7Y3BtLSZndDtvZmRldi0mZ3Q7ZGV2LCYjMTM7PGJyPgomZ3Q7
ICsmIzk7JiM5OyYjOTsmIzk7JiM5OyYjOTsmbmJzcDsmbmJzcDsgQ1BNX01BWF9SRUFEICsgMSwm
IzEzOzxicj4KJmd0OyArJiM5OyYjOTsmIzk7JiM5OyYjOTsmIzk7Jm5ic3A7Jm5ic3A7ICZhbXA7
Y3BtLSZndDt0eGRtYVtpXSwgR0ZQX0tFUk5FTCk7JiMxMzs8YnI+CiZndDsmbmJzcDsgJiM5OyYj
OTtpZiAoIWNwbS0mZ3Q7dHhidWZbaV0pIHsmIzEzOzxicj4KJmd0OyZuYnNwOyAmIzk7JiM5OyYj
OTtyZXQgPSAtRU5PTUVNOyYjMTM7PGJyPgomZ3Q7Jm5ic3A7ICYjOTsmIzk7JiM5O2dvdG8gb3V0
X211cmFtOyYjMTM7PGJyPgomZ3Q7IC0tICYjMTM7PGJyPgomZ3Q7IDIuMTcuMSYjMTM7PGJyPgom
Z3Q7ICYjMTM7PGJyPgo8L3A+CjwvYmxvY2txdW90ZT48L2Rpdj48YnI+PC9kaXY+

