From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: Greg Noel <GregNoel@san.rr.com>, linuxppc-dev@lists.linuxppc.org
Subject: Patch to fix glibc 2.1.2 so that new semaphore functions work in high signal env.
Date: Thu, 7 Oct 1999 23:56:19 -0400
Content-Type: Multipart/Mixed;
  boundary="Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD"
References: <37FA20A4.B9254E73@netscape.com> <v04011700b41f63005778@[204.210.50.90]> <v04011701b422cbe2027e@[204.210.50.90]>
In-Reply-To: <v04011701b422cbe2027e@[204.210.50.90]>
MIME-Version: 1.0
Message-Id: <99100800025201.16264@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



--Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

Hi,

I had to make the following patch to get glibc 2.1.2 new semaphores to work in
high signal environments.  For some reason calls to sem_post made by the
pthread manager thread were *NOT* resolving to the __new_sem_post but instead
to somewhere else (__old_sem_post or to kernel sem_post ????).

I don't know why (the correct fix might be somewhere else) but this does the
trick.

The pthread manager only does the sem_post calls when the original thread was
in a signal handler.

I am not sure this will help others, but it does wonders for the JDK!!!

Thanks,

Kevin

--Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD
Content-Type: text/x-c;
  name="glibc.patch"
Content-Description: patch to pthreads manager.c
Content-Disposition: attachment; filename="glibc.patch"
Content-Transfer-Encoding: base64

LS0tIG1hbmFnZXIuYy5wcmV2CVRodSBPY3QgIDcgMjM6NDA6MDQgMTk5OQorKysgbWFuYWdlci5j
CVRodSBPY3QgIDcgMjM6NDA6NDcgMTk5OQpAQCAtMTU2LDcgKzE1Niw3IEBACiAgICAgICAgIH0K
ICAgICAgICAgYnJlYWs7CiAgICAgICBjYXNlIFJFUV9QT1NUOgotICAgICAgICBzZW1fcG9zdChy
ZXF1ZXN0LnJlcV9hcmdzLnBvc3QpOworICAgICAgICBfX25ld19zZW1fcG9zdChyZXF1ZXN0LnJl
cV9hcmdzLnBvc3QpOwogICAgICAgICBicmVhazsKICAgICAgIGNhc2UgUkVRX0RFQlVHOgogCS8q
IE1ha2UgZ2RiIGF3YXJlIG9mIG5ldyB0aHJlYWQgYW5kIGdkYiB3aWxsIHJlc3RhcnQgdGhlCg==

--Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
