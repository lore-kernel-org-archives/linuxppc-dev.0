Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by lists.ozlabs.org (Postfix) with SMTP id DE3BA1A000E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 01:41:12 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 06797-08 for <linuxppc-dev@lists.ozlabs.org>;
 Wed, 25 Jun 2014 16:41:08 +0100 (BST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Guenter Roeck' <linux@roeck-us.net>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
 <u.kleine-koenig@pengutronix.de>
Subject: RE: [PATCH v2] sched: Fix compiler warnings
Date: Wed, 25 Jun 2014 15:40:28 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D17265D81@AcuExch.aculab.com>
References: <1403658329-13196-1-git-send-email-linux@roeck-us.net>
 <20140625071416.GM14781@pengutronix.de> <53AADC63.8080106@roeck-us.net>
 <20140625144955.GP14781@pengutronix.de> <53AAE4D2.5020104@roeck-us.net>
In-Reply-To: <53AAE4D2.5020104@roeck-us.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Russell King <linux@arm.linux.org.uk>,
 Peter Zijlstra <peterz@infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Vincent
 Guittot <vincent.guittot@linaro.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RnJvbTogR3VlbnRlciBSb2Vjaw0KPiBPbiAwNi8yNS8yMDE0IDA3OjQ5IEFNLCBVd2UgS2xlaW5l
LUtuaWcgd3JvdGU6DQo+ID4gSGVsbG8gR3VlbnRlciwNCj4gPg0KPiA+IE9uIFdlZCwgSnVuIDI1
LCAyMDE0IGF0IDA3OjI3OjQ3QU0gLTA3MDAsIEd1ZW50ZXIgUm9lY2sgd3JvdGU6DQo+ID4+PiBN
YXliZSB0aGUgYXV0aG9yJ3MgaW50ZW50aW9uIHdhczoNCj4gPj4+DQo+ID4+PiAJc3RhdGljIGlu
bGluZSBpbnQgY3B1X2NvcmVwb3dlcl9mbGFncyh2b2lkKSBfX2F0dHJpYnV0ZV9fKChjb25zdCkp
Ow0KPiA+Pj4NCj4gPj4+ID8NCj4gPj4+IFRoaXMgc3BlY2lmaWVzIHRoYXQgdGhlIGZ1bmN0aW9u
IGhhcyBubyBzaWRlIGVmZmVjdHMgYW5kIHRoZSByZXR1cm4gdmFsdWUNCj4gPj4+IG9ubHkgZGVw
ZW5kcyBvbiB0aGUgKGhlcmUgbm9uLWV4aXN0aW5nKSBmdW5jdGlvbiBhcmd1bWVudHMuDQo+ID4+
Pg0KPiA+Pg0KPiA+PiBQb3NzaWJseSwgYnV0IGVpdGhlciBJIGFtIG1pc3Npbmcgc29tZXRoaW5n
IG9yIHRoaXMgZG9lc24ndCBjb21waWxlLg0KPiA+IFlvdSBuZWVkIHRvIGRvIGEgc2VwYXJhdGUg
ZGVjbGFyYXRpb246DQo+ID4NCj4gPiAJc3RhdGljIGlubGluZSBpbnQgY3B1X2NvcmVwb3dlcl9m
bGFncyh2b2lkKSBfX2F0dHJpYnV0ZV9fKChjb25zdCkpOw0KPiA+IAlzdGF0aWMgaW5saW5lIGlu
dCBjcHVfY29yZXBvd2VyX2ZsYWdzKHZvaWQpDQo+ID4gCXsNCj4gPiAJCS4uLg0KPiANCj4gQWN0
dWFsbHkgdHVybnMgb3V0IG9uZSBjYW4gdXNlIF9fYXR0cmlidXRlX2NvbnN0X18sIGFuZCBpdCBp
cw0KPiANCj4gCXN0YXRpYyBpbmxpbmUgaW50IF9fYXR0cmlidXRlX2NvbnN0X18gY3B1X2NvcmVw
b3dlcl9mbGFncyh2b2lkKQ0KPiANCj4gd2hpY2ggdHVybnMgb3V0IHRvIGJlIHdpZGVseSB1c2Vk
Lg0KPiANCj4gSSdsbCBjaGFuZ2UgdGhhdCBhbmQgcmVzdWJtaXQgYWZ0ZXIgdGVzdGluZy4NCg0K
WW91IGRvbid0IG5lZWQgdG8gdGVsbCB0aGUgY29tcGlsZXIgdGhhdCBmb3IgYW4gaW5saW5lIGZ1
bmN0aW9uLg0KDQoJRGF2aWQNCg0K
