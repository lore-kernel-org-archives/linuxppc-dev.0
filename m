Date: Wed, 05 Dec 2001 15:27:05 -0800
From: Ira Weiny <iweiny@acm.org>
Subject: Re: kernel pcmcia drivers/ide-cs stopped working in ben's tree at >=
 2.4.16
In-reply-to: <200112052037.fB5KbG623486@mailout6-0.nyroc.rr.com>
To: linuxppc-dev@lists.linuxppc.org
Message-id: <20011205152705.373e5bcb.iweiny@acm.org>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_T9HusO+8rX3Fdd9I6vKzTw)"
References: <200112052037.fB5KbG623486@mailout6-0.nyroc.rr.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.

--Boundary_(ID_T9HusO+8rX3Fdd9I6vKzTw)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT

On Wed, 05 Dec 2001 15:37:15 -0500
Armando Di Cianno <armando@nycap.rr.com> wrote:

>
> I'm running my own distro (mostly LFS style), and using ben's sources.
> Hardware is a 400Mhz G4 TiBook.
>
> In 2.4.14-ben0, and 2.4.15-pre6-ben0, after pcmcia services are started,
> dmesg reports the same happy information (these examples done with a 340Mb
> IBM microdrive, but the symptoms happen for my 8 and 32Mb CF cards, with the
> same pcmcia adaptor):
> cs: memory probe 0x80000000-0x80ffffff: excluding 0x80000000-0x800fffff
> hde: IBM-DMDM-10340, ATA DISK drive
> ide2 at 0x100-0x107,0x10e on irq 58
> ide-floppy driver 0.97.sv
> hde: 700560 sectors (359 MB) w/96KiB Cache, CHS=695/16/63
>  /dev/ide/host2/bus0/target0/lun0: p1
> ide_cs: hde: Vcc = 3.3, Vpp = 0.0
>
> In 2.4.16-ben0, this is what dmesg reports:
> cs: memory probe 0x80000000-0x80ffffff: excluding 0x80000000-0x80ffffff
> cs: unable to map card memory!
> cs: unable to map card memory!
>
> In 2.4.17-pre2-ben0, in console mode, the laptop immeadiately shuts down; in
> X, the laptop freezes.
>
> I'm 99.9% sure my /etc/pcmcia/* info is correct (as it still works for older
> kernels, with all of the pcmcia-package version's I've tried).  If these
> symptoms can help any of the ppc kernel hackers solve this problem, I'd be so
> very happy.
>

Well...  I just did a diff of the files I modified to get my 1Gig Microdrive
working and I notice some differences.

Here are the diffs from my working kernel and an rsync of Ben's tree I did on
Dec 1.

I see that idecs_register has been removed in favor of ide_register?

I don't know why this was done.  I don't have time to upgrade my kernel right
now but I will try later.  What I do know is the "ide_disable_irq_on_probe" was
required because the 1Gig does not work with the std disable of IRQ's.
However, I think the 340Meg did?

Sorry I could not be of more help.
Ira Weiny
iweiny@acm.org


--Boundary_(ID_T9HusO+8rX3Fdd9I6vKzTw)
Content-type: application/octet-stream; name=ide-cs.patch
Content-transfer-encoding: base64
Content-disposition: attachment; filename=ide-cs.patch

NDVkNDQKPCAjaW5jbHVkZSA8bGludXgvaWRlLmg+CjIzMCwyNDFkMjI4CjwgaW50IGlkZWNzX3Jl
Z2lzdGVyIChpbnQgYXJnMSwgaW50IGFyZzIsIGludCBpcnEpCjwgewo8ICAgICAgICAgaHdfcmVn
c190IGh3Owo8ICAgICAgICAgaWRlX2luaXRfaHdpZl9wb3J0cygmaHcsIChpZGVfaW9yZWdfdCkg
YXJnMSwgKGlkZV9pb3JlZ190KSBhcmcyLCBOVUxMKTsKPCAgICAgICAgIGh3LmlycSA9IGlycTsK
PCAgICAgICAgIGh3LmNoaXBzZXQgPSBpZGVfcGNpOyAvLyB0aGlzIGVuYWJsZXMgSVJRIHNoYXJp
bmcgdy8gUENJIGlycXMKPCAgICAgICAgIHJldHVybiBpZGVfcmVnaXN0ZXJfaHcoJmh3LCBOVUxM
KTsKPCB9CjwgCjwgLyogSUtXIE1pY3JvZHJpdmUgbW9kICovCjwgZXh0ZXJuIGludCBpZGVfZGlz
YWJsZV9pcnFfb25fcHJvYmU7CjwgCjM0MywzNDdkMzI5CjwgICAgIC8qIElLVyBNaWNyb2RyaXZl
IG1vZCAqLwo8ICAgICBpZGVfZGlzYWJsZV9pcnFfb25fcHJvYmUgPSAxOwo8IAo8ICAgICBvdXRi
KDB4MDIsIGN0bF9iYXNlKTsgLy8gU2V0IG5JRU4gPSBkaXNhYmxlIGRldmljZSBpbnRlcnJ1cHRz
CjwgCjM1MGMzMzIKPCAJaGQgPSBpZGVjc19yZWdpc3Rlcihpb19iYXNlLCBjdGxfYmFzZSwgbGlu
ay0+aXJxLkFzc2lnbmVkSVJRKTsKLS0tCj4gCWhkID0gaWRlX3JlZ2lzdGVyKGlvX2Jhc2UsIGN0
bF9iYXNlLCBsaW5rLT5pcnEuQXNzaWduZWRJUlEpOwozNTMsMzU0YzMzNSwzMzYKPCAJICAgIGhk
ID0gaWRlY3NfcmVnaXN0ZXIoaW9fYmFzZSsweDEwLCBjdGxfYmFzZSsweDEwLAo8IAkJCQlsaW5r
LT5pcnEuQXNzaWduZWRJUlEpOwotLS0KPiAJICAgIGhkID0gaWRlX3JlZ2lzdGVyKGlvX2Jhc2Ur
MHgxMCwgY3RsX2Jhc2UrMHgxMCwKPiAJCQkgICAgICBsaW5rLT5pcnEuQXNzaWduZWRJUlEpOwoz
NjMsMzY1ZDM0NAo8IAo8ICAgICAvKiBJS1cgTWljcm9kcml2ZSBtb2QgKi8KPCAgICAgaWRlX2Rp
c2FibGVfaXJxX29uX3Byb2JlID0gMDsK

--Boundary_(ID_T9HusO+8rX3Fdd9I6vKzTw)
Content-type: application/octet-stream; name=ide-probe.patch
Content-transfer-encoding: base64
Content-disposition: attachment; filename=ide-probe.patch

MTc5LDE4MWQxNzgKPCAvKiBJS1cgTWljcm9kcml2ZSBtb2QgKi8KPCBpbnQgaWRlX2Rpc2FibGVf
aXJxX29uX3Byb2JlID0gMDsKPCAKMjE5LDIyNGQyMTUKPCAgICAgICAgIC8qIElLVyBNaWNyb2Ry
aXZlIG1vZCAqLwo8ICAgICAgICAgaWYgKGlkZV9kaXNhYmxlX2lycV9vbl9wcm9iZSA9PSAxKQo8
ICAgICAgICAgewo8ICAgICAgICAgICAgZGlzYWJsZV9pcnEoSFdJRihkcml2ZSktPmlycSk7Cjwg
ICAgICAgICB9CjwgCjIzMCwyMzRkMjIwCjwgICAgICAgICAgICAgICAgICAgICAgICAgLyogSUtX
IE1pY3JvZHJpdmUgbW9kICovCjwgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGlkZV9kaXNh
YmxlX2lycV9vbl9wcm9iZSA9PSAxKQo8ICAgICAgICAgICAgICAgICAgICAgICAgIHsKPCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVuYWJsZV9pcnEoSFdJRihkcml2ZSktPmlycSk7
CjwgICAgICAgICAgICAgICAgICAgICAgICAgfQoyNDQsMjQ4ZDIyOQo8ICAgICAgICAgICAgICAg
ICAgICAgICAgIC8qIElLVyBNaWNyb2RyaXZlIG1vZCAqLwo8ICAgICAgICAgICAgICAgICAgICAg
ICAgIGlmIChpZGVfZGlzYWJsZV9pcnFfb25fcHJvYmUgPT0gMSkKPCAgICAgICAgICAgICAgICAg
ICAgICAgICB7CjwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbmFibGVfaXJxKEhX
SUYoZHJpdmUpLT5pcnEpOwo8ICAgICAgICAgICAgICAgICAgICAgICAgIH0KMjY1LDI3MWQyNDUK
PCAKPCAgICAgICAgIC8qIElLVyBNaWNyb2RyaXZlIG1vZCAqLwo8ICAgICAgICAgaWYgKGlkZV9k
aXNhYmxlX2lycV9vbl9wcm9iZSA9PSAxKQo8ICAgICAgICAgewo8ICAgICAgICAgICAgICAgICBl
bmFibGVfaXJxKEhXSUYoZHJpdmUpLT5pcnEpOwo8ICAgICAgICAgfQo8IAo4MDhjNzgyCjwgCQkq
bWF4X3JhKysgPSBNQVhfUkVBREFIRUFEOwotLS0KPiAJCSptYXhfcmErKyA9IHZtX21heF9yZWFk
YWhlYWQ7Cg==

--Boundary_(ID_T9HusO+8rX3Fdd9I6vKzTw)
Content-type: application/octet-stream; name=ide.patch
Content-transfer-encoding: base64
Content-disposition: attachment; filename=ide.patch

MjMxMGQyMzA5CjwgCWh3aWYtPmNoaXBzZXQgPSBody0+Y2hpcHNldDsKMzM5NywzNDAyZDMzOTUK
PCAjaWZkZWYgQ09ORklHX0JMS19ERVZfQ1BDSTQwNV9JREUKPCAJewo8IAkJZXh0ZXJuIHZvaWQg
Y3BjaTQwNWlkZV9pbml0KHZvaWQpOwo8IAkJY3BjaTQwNWlkZV9pbml0KCk7CjwgCX0KPCAjZW5k
aWYgLyogQ09ORklHX0JMS19ERVZfQ1BDSTQwNV9JREUgKi8KMzY3NywzNjgwZDM2NjkKPCAKPCAv
KiBJS1cgTWljcm9kcml2ZSBtb2QgKi8KPCBleHRlcm4gaW50IGlkZV9kaXNhYmxlX2lycV9vbl9w
cm9iZTsKPCBFWFBPUlRfU1lNQk9MKGlkZV9kaXNhYmxlX2lycV9vbl9wcm9iZSk7Cg==

--Boundary_(ID_T9HusO+8rX3Fdd9I6vKzTw)--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
