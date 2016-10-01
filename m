Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x230.google.com (mail-wm0-x230.google.com
 [IPv6:2a00:1450:400c:c09::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3smRyL41HczDshg
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Oct 2016 22:12:26 +1000 (AEST)
Received: by mail-wm0-x230.google.com with SMTP id b80so88421815wme.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 01 Oct 2016 05:12:26 -0700 (PDT)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
In-Reply-To: <CA+7wUswqAh+6JLmLy=AmZJb7-mMqX0q-6fMyG_LsRECW4LwA3w@mail.gmail.com>
References: <CA+7wUsxzwTkWKgRH5yG2rNawcJZYYFLaQP0aun8YUD5eoC1i-g@mail.gmail.com>
 <1465874771.18900.4.camel@ellerman.id.au>
 <1465902911.30200.6.camel@kernel.crashing.org>
 <CA+7wUswqAh+6JLmLy=AmZJb7-mMqX0q-6fMyG_LsRECW4LwA3w@mail.gmail.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Sat, 1 Oct 2016 14:12:00 +0200
Message-ID: <CA+7wUsxU5yOz73YtUJrdjvw_UWDLg7oi5PHPDqbsxEbjiBoU1w@mail.gmail.com>
Subject: Fwd: Rational for having CONFIG_FB_RADEON=m
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: multipart/mixed; boundary=047d7ba97a107050c1053dcc9f2d
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--047d7ba97a107050c1053dcc9f2d
Content-Type: text/plain; charset=UTF-8

Hi Ben,

On Tue, Jun 14, 2016 at 1:15 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2016-06-14 at 13:26 +1000, Michael Ellerman wrote:
>> On Mon, 2016-06-13 at 17:46 +0200, Mathieu Malaterre wrote:
>>
>> > 2. Try to fix `radeonfb` so that it is able to kick offb out of the
>> > way. Eg: https://lists.freedesktop.org/archives/dri-devel/2010-Augu
>> > st/002907.html
>> >
>> > From my understanding it would make sense to go for (2), since it
>> > would allow for proper support for CONFIG_FB_RADEON=m on PowerMac.
>> > In
>> > this case, would such patch be accepted ?
>>
>> Sounds like the right fix to me. Ben's patch above was merged, so
>> it's supposed
>> to kick out offb AFAICS, the fact that it can't seems like a
>
> Make sure you have CONFIG_VT_HW_CONSOLE_BINDING=y

Thanks I do have it.

What I was trying to say in my broken fr-english is that I would like
to patch `drivers/video/fbdev/aty/radeon_base.c` the same way you did
`drivers/gpu/drm/radeon/radeon_drv.c` a long time ago.

So that there is no possible confusion, I am attaching my WIP. I know
you must be very busy, but I would really appreciate if you could
review this patch and give me some clue(s) as to why
`pci_request_region` still fails even if the call to
`radeon_kick_out_firmware_fb` succeeds in kicking out `offb` (I am
left with an empty /proc/fb).

In this case dmesg properly reveals that OFfb was kicked out but still
the `radeonfb` could not succeed:

[...]
 bus: 'pci': add driver radeonfb
 bus: 'pci': driver_probe_device: matched device 0000:00:10.0 with
driver radeonfb
 bus: 'pci': really_probe: probing driver radeonfb with device 0000:00:10.0
 devices_kset: Moving 0000:00:10.0 to end of list
 radeonfb_pci_register BEGIN
 checking generic (9c008000 96000) vs hw (98000000 8000000)
 fb: switching to radeonfb from OFfb ATY,RockHo
 Console: switching to colour dummy device 80x25
 device: 'fb0': device_unregister
 PM: Removing info for No Bus:fb0
 device: 'fb0': device_create_release
 radeonfb 0000:00:10.0: enabling device (0006 -> 0007)
 device: 'vtcon1': device_unregister
 PM: Removing info for No Bus:vtcon1
 device: 'vtcon1': device_create_release
 radeonfb 0000:00:10.0: BAR 0: can't reserve [mem 0x98000000-0x9fffffff pref]
 radeonfb (0000:00:10.0): cannot request region 0.
 radeonfb: probe of 0000:00:10.0 failed with error -16
[...]

The only way I found to load `radeonfb` is to use offb:off in yaboot.

Regards and thanks for your time,

--047d7ba97a107050c1053dcc9f2d
Content-Type: text/x-patch; charset=US-ASCII; name="radeonfp.patch"
Content-Disposition: attachment; filename="radeonfp.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ipgm3s1m0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlkZW8vZmJkZXYvYXR5L3JhZGVvbl9iYXNlLmMgYi9kcml2
ZXJzL3ZpZGVvL2ZiZGV2L2F0eS9yYWRlb25fYmFzZS5jCmluZGV4IDIxODMzOWEuLjFhOTFmZWIg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdmlkZW8vZmJkZXYvYXR5L3JhZGVvbl9iYXNlLmMKKysrIGIv
ZHJpdmVycy92aWRlby9mYmRldi9hdHkvcmFkZW9uX2Jhc2UuYwpAQCAtMjI1OSw2ICsyMjU5LDIy
IEBAIHN0YXRpYyBzdHJ1Y3QgYmluX2F0dHJpYnV0ZSBlZGlkMl9hdHRyID0gewogCS5yZWFkCT0g
cmFkZW9uX3Nob3dfZWRpZDIsCiB9OwogCitzdGF0aWMgaW50IHJhZGVvbl9raWNrX291dF9maXJt
d2FyZV9mYihzdHJ1Y3QgcGNpX2RldiAqcGRldikKK3sKKwlzdHJ1Y3QgYXBlcnR1cmVzX3N0cnVj
dCAqYXA7CisKKwlhcCA9IGFsbG9jX2FwZXJ0dXJlcygxKTsKKwlpZiAoIWFwKQorCQlyZXR1cm4g
LUVOT01FTTsKKworCWFwLT5yYW5nZXNbMF0uYmFzZSA9IHBjaV9yZXNvdXJjZV9zdGFydChwZGV2
LCAwKTsKKwlhcC0+cmFuZ2VzWzBdLnNpemUgPSBwY2lfcmVzb3VyY2VfbGVuKHBkZXYsIDApOwor
CisJcmVtb3ZlX2NvbmZsaWN0aW5nX2ZyYW1lYnVmZmVycyhhcCwgS0JVSUxEX01PRE5BTUUsIGZh
bHNlKTsKKwlrZnJlZShhcCk7CisKKwlyZXR1cm4gMDsKK30KIAogc3RhdGljIGludCByYWRlb25m
Yl9wY2lfcmVnaXN0ZXIoc3RydWN0IHBjaV9kZXYgKnBkZXYsCiAJCQkJIGNvbnN0IHN0cnVjdCBw
Y2lfZGV2aWNlX2lkICplbnQpCkBAIC0yMzE0LDYgKzIzMzAsMTAgQEAgc3RhdGljIGludCByYWRl
b25mYl9wY2lfcmVnaXN0ZXIoc3RydWN0IHBjaV9kZXYgKnBkZXYsCiAJcmluZm8tPmZiX2Jhc2Vf
cGh5cyA9IHBjaV9yZXNvdXJjZV9zdGFydCAocGRldiwgMCk7CiAJcmluZm8tPm1taW9fYmFzZV9w
aHlzID0gcGNpX3Jlc291cmNlX3N0YXJ0IChwZGV2LCAyKTsKIAorCXJldCA9IHJhZGVvbl9raWNr
X291dF9maXJtd2FyZV9mYihwZGV2KTsKKwlpZiAocmV0KQorCQlyZXR1cm4gcmV0OworCiAJLyog
cmVxdWVzdCB0aGUgbWVtIHJlZ2lvbnMgKi8KIAlyZXQgPSBwY2lfcmVxdWVzdF9yZWdpb24ocGRl
diwgMCwgInJhZGVvbmZiIGZyYW1lYnVmZmVyIik7CiAJaWYgKHJldCA8IDApIHsK
--047d7ba97a107050c1053dcc9f2d--
