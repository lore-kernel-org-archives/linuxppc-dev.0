Date: Tue, 5 Jan 1999 07:36:53 -0700 (MST)
From: Brad Midgley <brad@pht.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: real-root-dev patches (another approach)
Message-ID: <Pine.LNX.3.96LJ1.1b7.990105073517.842A-200000@cricket>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="133633-1958519968-915547013=:842"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--133633-1958519968-915547013=:842
Content-Type: TEXT/PLAIN; charset=US-ASCII

i emailed this to alan cox. i will send it to linus and the lists later.

Reading or writing /proc/sys/kernel/real-root-dev does not work on
big-endian architectures. I propose a multiplatform solution.

The reason it doesn't work is that sysctl is told to treat the
corresponding variable, real_root_dev, as if it's an int. It's
actually of type kdev_t which is ultimately an unsigned short
int. Treating it like an int only works on x86 because of
(unfortunate?) alignment coincidence. Even on intel where this code
works, two adjacent bytes that don't really belong to real_root_dev
are being read and modified as if they do.

This code needs to work on all platforms because it is extremely
important for makers of linux distributions to offer convenient
startup options.

As I see it there are three ways to fix the problem:

1. Change real_root_dev to type int 
(ugly, it really should be a kdev_t)

2. Change the definition of kdev_t from an unsigned short to an int 
(ugly, affects large amounts of code)

3. make sysctl treat real_root_dev properly as it is.

I show an implementation for (3). I think it's the best solution and
it's the most localized solution.

All my changes are in kernel/sysctl.c. The version is 2.2.0p4.

First I made the change to have the real size of real_root_dev
reflected in its entry in the table:

-{KERN_REALROOTDEV, "real-root-dev", &real_root_dev, sizeof(int),
+{KERN_REALROOTDEV, "real-root-dev", &real_root_dev, sizeof(real_root_dev),

If the size of kdev_t ever does change to a whole int or multiple
ints, the sysctl code won't need changes. (there's an assumption that
userland programs understand how real_root_dev is represented but
that's an entirely different problem)

Next I make the code that parses and outputs values able to deal with
a data chunk smaller than an int. I have it assume that a chunk of
data smaller than an int is an unsigned short. All the other entries
in the sysctl table report their size as multiples of sizeof(int) so
this doesn't affect any other entries.

vleft now represents the number of bytes, not ints, that need to be
filled:

-	vleft = table->maxlen / sizeof(int);
+	vleft = table->maxlen;
 	left = *lenp;
 	
-	for (; left && vleft--; i++, first=0) {
+	for (; left && vleft > 0; i++, first=0) {
+		vleft -= sizeof(int);
 		if (write) {
...
 			left -= len;
-			*i = val;
+			if(vleft >= 0)
+				*i = val;
+			else
+				*((unsigned short *)i) = val;
 		} else {
 			p = buf;
 			if (!first)
 				*p++ = '\t';
-			sprintf(p, "%d", (*i) / conv);
+			if(vleft >= 0)
+				sprintf(p, "%d", (*i) / conv);
+			else
+				sprintf(p, "%hd", (*((unsigned short *)i)) / conv);
 			len = strlen(buf);
 			if (len > left)
 				len = left;

a proper patch is attached.

brad

--133633-1958519968-915547013=:842
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="sysctl.c.diff"
Content-ID: <Pine.LNX.3.96LJ1.1b7.990105073653.842B@cricket>
Content-Description: 
Content-Transfer-Encoding: BASE64

LS0tIGtlcm5lbC9zeXNjdGwuYy5vcmlnCU1vbiBKYW4gIDQgMjA6MDI6MDIg
MTk5OQ0KKysrIGtlcm5lbC9zeXNjdGwuYwlUdWUgSmFuICA1IDAzOjQyOjE2
IDE5OTkNCkBAIC0xNjIsNyArMTYyLDcgQEANCiAJe0tFUk5fUEFOSUMsICJw
YW5pYyIsICZwYW5pY190aW1lb3V0LCBzaXplb2YoaW50KSwNCiAJIDA2NDQs
IE5VTEwsICZwcm9jX2RvaW50dmVjfSwNCiAjaWZkZWYgQ09ORklHX0JMS19E
RVZfSU5JVFJEDQotCXtLRVJOX1JFQUxST09UREVWLCAicmVhbC1yb290LWRl
diIsICZyZWFsX3Jvb3RfZGV2LCBzaXplb2YoaW50KSwNCisJe0tFUk5fUkVB
TFJPT1RERVYsICJyZWFsLXJvb3QtZGV2IiwgJnJlYWxfcm9vdF9kZXYsIHNp
emVvZihyZWFsX3Jvb3RfZGV2KSwNCiAJIDA2NDQsIE5VTEwsICZwcm9jX2Rv
aW50dmVjfSwNCiAjZW5kaWYNCiAjaWZkZWYgQ09ORklHX0JJTkZNVF9KQVZB
DQpAQCAtNjg4LDEwICs2ODgsMTEgQEANCiAJfQ0KIAkNCiAJaSA9IChpbnQg
KikgdGFibGUtPmRhdGE7DQotCXZsZWZ0ID0gdGFibGUtPm1heGxlbiAvIHNp
emVvZihpbnQpOw0KKwl2bGVmdCA9IHRhYmxlLT5tYXhsZW47DQogCWxlZnQg
PSAqbGVucDsNCiAJDQotCWZvciAoOyBsZWZ0ICYmIHZsZWZ0LS07IGkrKywg
Zmlyc3Q9MCkgew0KKwlmb3IgKDsgbGVmdCAmJiB2bGVmdCA+IDA7IGkrKywg
Zmlyc3Q9MCkgew0KKwkJdmxlZnQgLT0gc2l6ZW9mKGludCk7DQogCQlpZiAo
d3JpdGUpIHsNCiAJCQl3aGlsZSAobGVmdCkgew0KIAkJCQljaGFyIGM7DQpA
QCAtNzI2LDEyICs3MjcsMTggQEANCiAJCQkJdmFsID0gLXZhbDsNCiAJCQli
dWZmZXIgKz0gbGVuOw0KIAkJCWxlZnQgLT0gbGVuOw0KLQkJCSppID0gdmFs
Ow0KKwkJCWlmKHZsZWZ0ID49IDApDQorCQkJCSppID0gdmFsOw0KKwkJCWVs
c2UNCisJCQkJKigodW5zaWduZWQgc2hvcnQgKilpKSA9IHZhbDsNCiAJCX0g
ZWxzZSB7DQogCQkJcCA9IGJ1ZjsNCiAJCQlpZiAoIWZpcnN0KQ0KIAkJCQkq
cCsrID0gJ1x0JzsNCi0JCQlzcHJpbnRmKHAsICIlZCIsICgqaSkgLyBjb252
KTsNCisJCQlpZih2bGVmdCA+PSAwKQ0KKwkJCQlzcHJpbnRmKHAsICIlZCIs
ICgqaSkgLyBjb252KTsNCisJCQllbHNlDQorCQkJCXNwcmludGYocCwgIiVo
ZCIsICgqKCh1bnNpZ25lZCBzaG9ydCAqKWkpKSAvIGNvbnYpOw0KIAkJCWxl
biA9IHN0cmxlbihidWYpOw0KIAkJCWlmIChsZW4gPiBsZWZ0KQ0KIAkJCQls
ZW4gPSBsZWZ0Ow0K
--133633-1958519968-915547013=:842--

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
