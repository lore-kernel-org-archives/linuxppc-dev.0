Message-ID: <3968A9E4.256BDDBA@noos.fr>
Date: Sun, 09 Jul 2000 18:35:48 +0200
From: Guillaume Laurès <guillaume.laures@noos.fr>
Reply-To: guillaume.laures@noos.fr
MIME-Version: 1.0
To: mlan@cpu.lu
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Trying to enable backside on a G4
References: <200007081724.TAA00758@piglet.grunz.lu>
Content-Type: multipart/mixed;
 boundary="------------BBD9F0758C7ED78D5920D79C"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Il s'agit d'un message multivolet au format MIME.
--------------BBD9F0758C7ED78D5920D79C
Content-Type: text/plain; charset=iso-8859-1; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Content-Transfer-Encoding: 8bit



Michel Lanners a écrit :

>
> Attached are actually two patches: the first one fixes the output of
> 'cat /proc/sys/kernel/l2cr', as it contains some errors and omissions.
> This part is only needed on 2.2.x and old 2.3.x kernels; it's integrated
> in 2.4.0-something.

Yes it is.

>
>
> The second patch adds command line functionality for 2.3/2.4 kernels.

Hum, it was included already in 2.4 from linuxcare.

I attached what gives a boot on my G4/8600 with "as it comes options in menuconfig" (exept for the
Adaptec stuff which I had to put in a module or I would still get forever
"SCSI host 2 channel 0 reset (pid 1942) timed out - trying harder
SCSI bus is being reset for host 2 channel 0."

What can I say :
l2cr seems not to be enabled, as confirms a cat /proc/... later
There is a conflict on the Adaptec 3940UW board which wasn't there on 2.2
There is still the "SCSI bus is being reset for host..." problem for the usable half of the card (may
be it's a firmware issue, I use the 4.1/AV firmaware)
eth0 and eth1 have been swapped, which is not cool since this box is may IP-Masqu box...

>
> I'll have to check whether all the steps I've taken to enable the cache
> are actually needed, since all the invalidate stuff should be handled by
> the function I'm calling. But it didn't work last I tried.... Once
> that's decided, I will resubmit the command line patch.

Taken from Motorola's G4 User's Manual is the following :

3.7.4 L2 Cache Initialization
Following a power-on or hard reset, the L2 cache and the L2 cache DLL are disabled
initially. Before enabling the L2 cache, the L2 cache DLL must first be configured through
the L2CR register, and the DLL must be allowed 640 L2 cache clock periods to achieve
phase lock. Before enabling the L2 cache, other configuration parameters must be set in the
L2CR, and the L2 cache tags must be globally invalidated. The L2 cache should be
initialized during system start-up.
The sequence for initializing the L2 cache is as follows:
1.  (automatically performed by the assertion of HRESET).
2. Disable L2 cache by clearing L2CR[L2E].
3. Set the L2CR[L2CLK] bits to the desired clock divider setting. Setting a nonzero
value automatically enables the DLL. All other L2 cache configuration bits should
be set to properly configure the L2 cache interface for the SRAM type, size, and
interface timing required.
4. Wait for the L2 cache DLL to achieve phase lock. This can be timed by setting the
decrementer for a time period equal to 640 L2 cache clocks, or by performing an L2
cache global invalidate.
5. Perform an L2 cache global invalidate. The global invalidate could be performed
before enabling the DLL, or in parallel with waiting for the DLL to stabilize. Refer
to Section 3.7.3.7, "L2 Cache Global Invalidation," for more information about L2
cache global invalidation. Note that a global invalidate always takes much longer
than it takes for the DLL to stabilize.
6. After the DLL stabilizes, an L2 cache global invalidate has been performed, and the
other L2 cache configuration bits have been set, enable the L2 cache for normal
operation by setting the L2CR[L2E] bit to 1.

So I attached a correct (I think) user-space script called L2BS_enable.sh which I'm going to
propagate on linuxppc-users, tell me what you think about. I will try to work on kernel space then.

I'm just unsure of the behaviour of :
while test 1 = $((`cat /proc/sys/kernel/l2cr | awk -F : '{print $1}'`&0x00000001)); do wait; done

I couldn't test this loop.

>
>
> > Since :
> >  - GrabG3CacheSetting (slightly modified to accept any processor or it would complain that I
> > don't have a G3...) from BenH told me that XLR8's extension sets my G4's L2CR to 0xb5100000
>
> Yeah, could you submit that back to Ben? I've noticed that as well when
> I started to play l2cr...

I did, but it's not good yet. Here is what I did :
Original code is :
[...]
if (cpuFamily != gestaltCPU750)
 {
  printf("Error, CPU is not a G3\n");
  exit(0);
 }
 printf ("Getting value of G3 L2CR register ...\n");
[...]

I put :
[...]
 if ((cpuFamily != gestaltCPU750) || (cpuFamily != gestaltCPU7400))
 {
  printf("Error, CPU is not a G3, nor a G4\n");
  exit(0);
 }
[...]
but it doesn't compile, so I had to comment out the whole test... Does anybody knows how to identify
a G4 under MacOS ?




Bye bye,


--
Guillaume


--------------BBD9F0758C7ED78D5920D79C
Content-Type: application/octet-stream; x-mac-type="42494E41"; x-mac-creator="554E4958";
 name="dmesg.out"
Content-Description: Document
Content-Disposition: attachment;
 filename="dmesg.out"
Content-Transfer-Encoding: base64

VG90YWwgbWVtb3J5ID0gMTkyTUI7IHVzaW5nIDEwMjRrQiBmb3IgaGFzaCB0YWJsZSAoYXQg
YzAzMDAwMDApCkxpbnV4IHZlcnNpb24gMi40LjAtdGVzdDEtYWMyMSAocm9vdEBwbTg2MDAp
IChnY2MgdmVyc2lvbiAyLjk1LjIgMjAwMDAzMTMgKERlYmlhbiBHTlUvTGludXgpKSAjMiBT
dW4gSnVsIDkgMTM6MTY6MDAgQ0VTVCAyMDAwClBDSSBidXNlcyAwLi4xIGNvbnRyb2xsZWQg
YnkgYmFuZGl0IGF0IGYyMDAwMDAwCkNhY2hlIGNvaGVyZW5jeSBlbmFibGVkIGZvciBiYW5k
aXQvUFNYIGF0IGY3ZmVkMDAwClBDSSBidXMgMiBjb250cm9sbGVkIGJ5IGNoYW9zIGF0IGYw
MDAwMDAwCk9uIG5vZGUgMCB0b3RhbHBhZ2VzOiA0OTE1Mgp6b25lKDApOiA0OTE1MiBwYWdl
cy4Kem9uZSgxKTogMCBwYWdlcy4Kem9uZSgyKTogMCBwYWdlcy4KS2VybmVsIGNvbW1hbmQg
bGluZTogcm9vdD0vZGV2L3NkYTUgdmlkZW89Y29udHJvbGZiOnZtb2RlOjE4LGNtb2RlOjgg
bDJjcj1iNTEwMDAwMCBkZXZmcz1ub21vdW50IApsMmNyIHNldCB0byAwClN5c3RlbSBoYXMg
MzIgcG9zc2libGUgaW50ZXJydXB0cwp2aWFfY2FsaWJyYXRlX2RlY3I6IGRlY3JlbWVudGVy
X2NvdW50ID0gMTI0OTkxICg3NDk5NTAgdGlja3MpCkNvbnNvbGU6IGNvbG91ciBkdW1teSBk
ZXZpY2UgODB4MjUKQ2FsaWJyYXRpbmcgZGVsYXkgbG9vcC4uLiA2OTkuNjAgQm9nb01JUFMK
TWVtb3J5OiAxODg4OTJrIGF2YWlsYWJsZSAoMTY0MGsga2VybmVsIGNvZGUsIDg2NGsgZGF0
YSwgMzAwayBpbml0KSBbYzAwMDAwMDAsY2MwMDAwMDBdCkRlbnRyeS1jYWNoZSBoYXNoIHRh
YmxlIGVudHJpZXM6IDMyNzY4IChvcmRlcjogNiwgMjYyMTQ0IGJ5dGVzKQpCdWZmZXItY2Fj
aGUgaGFzaCB0YWJsZSBlbnRyaWVzOiAxNjM4NCAob3JkZXI6IDQsIDY1NTM2IGJ5dGVzKQpQ
YWdlLWNhY2hlIGhhc2ggdGFibGUgZW50cmllczogNjU1MzYgKG9yZGVyOiA2LCAyNjIxNDQg
Ynl0ZXMpCmttZW1fY3JlYXRlOiBQb2lzb25pbmcgcmVxdWVzdGVkLCBidXQgY29uIGdpdmVu
IC0gYmRldl9jYWNoZQpJbm9kZS1jYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDE2Mzg0IChv
cmRlcjogNSwgMTMxMDcyIGJ5dGVzKQprbWVtX2NyZWF0ZTogUG9pc29uaW5nIHJlcXVlc3Rl
ZCwgYnV0IGNvbiBnaXZlbiAtIGlub2RlX2NhY2hlCmttZW1fY3JlYXRlOiBQb2lzb25pbmcg
cmVxdWVzdGVkLCBidXQgY29uIGdpdmVuIC0gZmlsZSBsb2NrIGNhY2hlClBPU0lYIGNvbmZv
cm1hbmNlIHRlc3RpbmcgYnkgVU5JRklYClBDSTogUHJvYmluZyBQQ0kgaGFyZHdhcmUKUENJ
OiBBZGRyZXNzIHNwYWNlIGNvbGxpc2lvbiBvbiByZWdpb24gMSBvZiBkZXZpY2UgQWRhcHRl
YyBBSEEtMzk0MFUvVVcgLyBBSUMtNzg4MlUKUENJOiBBZGRyZXNzIHNwYWNlIGNvbGxpc2lv
biBvbiByZWdpb24gNiBvZiBkZXZpY2UgQWRhcHRlYyBBSEEtMzk0MFUvVVcgLyBBSUMtNzg4
MlUKUENJOiBBZGRyZXNzIHNwYWNlIGNvbGxpc2lvbiBvbiByZWdpb24gMCBvZiBkZXZpY2Ug
QWRhcHRlYyBBSEEtMzk0MFUvVVcgLyBBSUMtNzg4MlUgKCMyKQpQQ0k6IEFkZHJlc3Mgc3Bh
Y2UgY29sbGlzaW9uIG9uIHJlZ2lvbiAxIG9mIGRldmljZSBBZGFwdGVjIEFIQS0zOTQwVS9V
VyAvIEFJQy03ODgyVSAoIzIpClBDSTogQWRkcmVzcyBzcGFjZSBjb2xsaXNpb24gb24gcmVn
aW9uIDYgb2YgZGV2aWNlIEFkYXB0ZWMgQUhBLTM5NDBVL1VXIC8gQUlDLTc4ODJVICgjMikK
dXNiLmM6IHJlZ2lzdGVyZWQgbmV3IGRyaXZlciBodWIKTGludXggTkVUNC4wIGZvciBMaW51
eCAyLjMKQmFzZWQgdXBvbiBTd2Fuc2VhIFVuaXZlcnNpdHkgQ29tcHV0ZXIgU29jaWV0eSBO
RVQzLjAzOQprbWVtX2NyZWF0ZTogUG9pc29uaW5nIHJlcXVlc3RlZCwgYnV0IGNvbiBnaXZl
biAtIHNrYnVmZl9oZWFkX2NhY2hlCk5FVDQ6IFVuaXggZG9tYWluIHNvY2tldHMgMS4wL1NN
UCBmb3IgTGludXggTkVUNC4wLgpORVQ0OiBMaW51eCBUQ1AvSVAgMS4wIGZvciBORVQ0LjAK
SVAgUHJvdG9jb2xzOiBJQ01QLCBVRFAsIFRDUCwgSUdNUApJUDogcm91dGluZyBjYWNoZSBo
YXNoIHRhYmxlIG9mIDIwNDggYnVja2V0cywgMTZLYnl0ZXMKVENQOiBIYXNoIHRhYmxlcyBj
b25maWd1cmVkIChlc3RhYmxpc2hlZCAxNjM4NCBiaW5kIDE2Mzg0KQpTdGFydGluZyBrc3dh
cGQgdjEuNgpjb250cm9sZmI6IE1lbW9yeSBiYW5rIDEgcHJlc2VudCwgYmFuayAyIGFic2Vu
dCwgdG90YWwgVlJBTSAyTUIKTW9uaXRvciBzZW5zZSB2YWx1ZSA9IDB4NjIzLCB1c2luZyB2
aWRlbyBtb2RlIDE4IGFuZCBjb2xvciBtb2RlIDAuCkNvbnNvbGU6IHN3aXRjaGluZyB0byBj
b2xvdXIgZnJhbWUgYnVmZmVyIGRldmljZSAxNDR4NTQKZmIwOiBjb250cm9sIGRpc3BsYXkg
YWRhcHRlcgpQb3dlck1hYyBaODUzMCBzZXJpYWwgZHJpdmVyIHZlcnNpb24gMi4wCnR0eTAw
IGF0IDB4Y2Q4MDkwMjAgKGlycSA9IDE1KSBpcyBhIFo4NTMwIEVTQ0MsIHBvcnQgPSBtb2Rl
bQp0dHkwMSBhdCAweGNkODEwMDAwIChpcnEgPSAxNikgaXMgYSBaODUzMCBFU0NDLCBwb3J0
ID0gcHJpbnRlcgpwdHk6IDI1NiBVbml4OTggcHR5cyBjb25maWd1cmVkClJBTURJU0sgZHJp
dmVyIGluaXRpYWxpemVkOiAxNiBSQU0gZGlza3Mgb2YgNDA5Nksgc2l6ZSAxMDI0IGJsb2Nr
c2l6ZQpsb29wOiByZWdpc3RlcmVkIGRldmljZSBhdCBtYWpvciA3Cmxvb3A6IGVuYWJsaW5n
IDggbG9vcCBkZXZpY2VzClVuaWZvcm0gTXVsdGktUGxhdGZvcm0gRS1JREUgZHJpdmVyIFJl
dmlzaW9uOiA2LjMxCmlkZTogQXNzdW1pbmcgMzNNSHogc3lzdGVtIGJ1cyBzcGVlZCBmb3Ig
UElPIG1vZGVzOyBvdmVycmlkZSB3aXRoIGlkZWJ1cz14eApmZDA6IFNXSU0zIGZsb3BweSBj
b250cm9sbGVyIApzY3NpMCA6IE1FU0gKc2NzaTEgOiA1M0M5NApzY3NpIDogMiBob3N0cy4K
bWVzaDogdGFyZ2V0IDAgc3luY2hyb25vdXMgYXQgNS4wIE1CL3MKICBWZW5kb3I6IFNFQUdB
VEUgICBNb2RlbDogU1QzNDUyME4gICAgICAgICAgUmV2OiAxMjgxCiAgVHlwZTogICBEaXJl
Y3QtQWNjZXNzICAgICAgICAgICAgICAgICAgICAgIEFOU0kgU0NTSSByZXZpc2lvbjogMDIK
RGV0ZWN0ZWQgc2NzaSBkaXNrIHNkYSBhdCBzY3NpMCwgY2hhbm5lbCAwLCBpZCAwLCBsdW4g
MAptZXNoOiB0YXJnZXQgMyBzeW5jaHJvbm91cyBhdCA1LjAgTUIvcwogIFZlbmRvcjogUElP
TkVFUiAgIE1vZGVsOiBEVkQtUk9NIERWRC0zMDMgICBSZXY6IDEuMTAKICBUeXBlOiAgIENE
LVJPTSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQU5TSSBTQ1NJIHJldmlzaW9uOiAw
MgpEZXRlY3RlZCBzY3NpIENELVJPTSBzcjAgYXQgc2NzaTAsIGNoYW5uZWwgMCwgaWQgMywg
bHVuIDAKICBWZW5kb3I6IElPTUVHQSAgICBNb2RlbDogWklQIDEwMCAgICAgICAgICAgUmV2
OiBFLjA4CiAgVHlwZTogICBEaXJlY3QtQWNjZXNzICAgICAgICAgICAgICAgICAgICAgIEFO
U0kgU0NTSSByZXZpc2lvbjogMDIKRGV0ZWN0ZWQgc2NzaSByZW1vdmFibGUgZGlzayBzZGIg
YXQgc2NzaTAsIGNoYW5uZWwgMCwgaWQgNSwgbHVuIDAKc2NzaSA6IGRldGVjdGVkIDEgU0NT
SSBjZHJvbSAyIFNDU0kgZGlza3MgdG90YWwuCnNyMDogc2NzaTMtbW1jIGRyaXZlOiAweC8w
eCBjZC9ydyB4YS9mb3JtMiBjZGRhIHRyYXkKVW5pZm9ybSBDRC1ST00gZHJpdmVyIFJldmlz
aW9uOiAzLjExClNDU0kgZGV2aWNlIHNkYTogaGR3ciBzZWN0b3I9IDUxMiBieXRlcy4gU2Vj
dG9ycz0gODg4ODkyNCBbNDM0MCBNQl0gWzQuMyBHQl0KUGFydGl0aW9uIGNoZWNrOgogL2Rl
di9zY3NpL2hvc3QwL2J1czAvdGFyZ2V0MC9sdW4wOiBwMSBwMiBwMyBwNCBwNSBwNiBwNyBw
OApzZGIgOiBSRUFEIENBUEFDSVRZIGZhaWxlZC4Kc2RiIDogc3RhdHVzID0gMCwgbWVzc2Fn
ZSA9IDAwLCBob3N0ID0gMCwgZHJpdmVyID0gMDggCnNkYiA6IGV4dGVuZGVkIHNlbnNlIGNv
ZGUgPSAyIApzZGIgOiBibG9jayBzaXplIGFzc3VtZWQgdG8gYmUgNTEyIGJ5dGVzLCBkaXNr
IHNpemUgMUdCLiAgCiAvZGV2L3Njc2kvaG9zdDAvYnVzMC90YXJnZXQ1L2x1bjA6IEkvTyBl
cnJvcjogZGV2IDA4OjEwLCBzZWN0b3IgMAogdW5hYmxlIHRvIHJlYWQgcGFydGl0aW9uIHRh
YmxlCmV0aDA6IERDMjExNDAgYXQgMHgyMDAwIChQQ0kgYnVzIDAsIGRldmljZSAxNSksIGgv
dyBhZGRyZXNzIDAwOjAwOjk0OmE5OjcwOjdjLApldGgwOiBVc2luZyBnZW5lcmljIE1JSSBk
ZXZpY2UgY29udHJvbC4gSWYgdGhlIGJvYXJkIGRvZXNuJ3Qgb3BlcmF0ZSwgCnBsZWFzZSBt
YWlsIHRoZSBmb2xsb3dpbmcgZHVtcCB0byB0aGUgYXV0aG9yOgoKTUlJIGRldmljZSBhZGRy
ZXNzOiAxCk1JSSBDUjogIDMxMDAKTUlJIFNSOiAgNzgwOQpNSUkgSUQwOiAxODEKTUlJIElE
MTogYjgwMgpNSUkgQU5BOiA1ZTEKTUlJIEFOQzogMApNSUkgMTY6ICA2NDAKTUlJIDE3OiAg
ZjAxMApNSUkgMTg6ICA2ODAwCgogICAgICBhbmQgcmVxdWlyZXMgSVJRMjUgKHByb3ZpZGVk
IGJ5IFBDSSBCSU9TKS4KZGU0eDUuYzpWMC41NDUgMTk5OS8xMS8yOCBkYXZpZXNAbWFuaWFj
LnVsdHJhbmV0LmNvbQpNYWNpbnRvc2ggQURCIG1vdXNlIGRyaXZlciBpbnN0YWxsZWQuCmV0
aDE6IE1BQ0UgYXQgMDA6MDU6MDI6Y2U6YzY6MWQsIGNoaXAgcmV2aXNpb24gMjUuNjQKRE1B
IHNvdW5kIGRyaXZlciBpbnN0YWxsZWQsIHVzaW5nIDQgYnVmZmVycyBvZiAzMmsuCmFkYjog
Q1VEQSBkcml2ZXIgdjAuNSBmb3IgVW5pZmllZCBBREIuCmFkYiBkZXZpY2VzOiBbMl06IDIg
NSBbM106IDMgMQpBREIga2V5Ym9hcmQgYXQgMiwgaGFuZGxlciBzZXQgdG8gMwpBREIgbW91
c2UgYXQgMywgaGFuZGxlciBzZXQgdG8gMgpNYWNpbnRvc2ggbm9uLXZvbGF0aWxlIG1lbW9y
eSBkcml2ZXIgdjEuMAp1c2IuYzogcmVnaXN0ZXJlZCBuZXcgZHJpdmVyIGhpZAptaWNlOiBQ
Uy8yIG1vdXNlIGRldmljZSBjb21tb24gZm9yIGFsbCBtaWNlCmRldmZzOiB2MC45NiAoMjAw
MDA0MzApIFJpY2hhcmQgR29vY2ggKHJnb29jaEBhdG5mLmNzaXJvLmF1KQpkZXZmczogYm9v
dF9vcHRpb25zOiAweDIKa21lbV9jcmVhdGU6IEZvcmNpbmcgc2l6ZSB3b3JkIGFsaWdubWVu
dCAtIG5mc19maApWRlM6IE1vdW50ZWQgcm9vdCAoZXh0MiBmaWxlc3lzdGVtKSByZWFkb25s
eS4KRnJlZWluZyB1bnVzZWQga2VybmVsIG1lbW9yeTogMzAwayBpbml0IDM2ayBwcmVwIDhr
IGNocnAKQWRkaW5nIFN3YXA6IDE5NjYwMGsgc3dhcC1zcGFjZSAocHJpb3JpdHkgLTEpCmV0
aDA6IG1lZGlhIGlzIDEwME1iL3MuCmV0aDA6IG1lZGlhIGlzIFRQLgpldGgwOiBtZWRpYSBp
cyAxMDBNYi9zLgphcnB3YXRjaCB1c2VzIG9ic29sZXRlIChQRl9JTkVULFNPQ0tfUEFDS0VU
KQpkZXZpY2UgZXRoMSBlbnRlcmVkIHByb21pc2N1b3VzIG1vZGUKZXRoMDogbWVkaWEgaXMg
VFAuCg==

--------------BBD9F0758C7ED78D5920D79C
Content-Type: application/x-sh; x-mac-type="54455854"; x-mac-creator="522A6368";
 name="L2BS_enable.sh"
Content-Description: Unknown Document
Content-Disposition: inline;
 filename="L2BS_enable.sh"
Content-Transfer-Encoding: 7bit

#!/bin/sh
# Script used to enable backside cache on a G3/G4 upgrade processor board in PCI pre-G3 Macs
# Written and tested on a 8600/250 upgraded with a MACh Carrier G4 350/233 board (Yeah ;-)
# Guillaume Laures - 09/07/2000

#
# RUN THIS SCRIPT ON BOOT TIME *AS SOON AS POSSIBLE*
# for example, in /etc/rc.d/rc.sysinit on LinuxPPC 1999/2000
#

#
# RUN THIS SCRIPT AT YOUR OWN RISK, DON'T BLAME ME IF IT BURNS YOUR CARD
#

#
# YOU HAVE BEEN WARNED ! I WON'T ACCEPT TO BE TAKEN FOR RESPONSIBLE FOR ANY DATA LOSS EITHER
# besides that, if you follow the settings given by the vendor's software all should run fine
#

case "$1" in
    start)

        echo -n "Enabling G3/G4 level2 backside cache..."

    # Motorola Step 1 : Power-on reset, already done ;-)

    # Motorola step 2 : Disable L2 cache
        echo 0 > /proc/sys/kernel/l2cr

    # Motorola step 3 : Set the L2CR[L2CLK] bits and all other L2 cache configuration bits
		echo '0x_what_your_card_supports_minus_L2E_bit' > /proc/sys/kernel/l2cr

	# Motorola step 4/5 : Wait for the L2 cache DLL to achieve phase lock by performing an L2 cache global invalidate
		echo '0x_what_your_card_supports_minus_L2E_bit_plus L2I_bit' > /proc/sys/kernel/l2cr

	# Motorola step 6 :6. After the L2 cache global invalidate has been performed enable the L2 cache
		echo '0x_what_your_card_supports' > /proc/sys/kernel/l2cr
        echo '0x35300000' > /proc/sys/kernel/l2cr
        echo '0xb5100000' > /proc/sys/kernel/l2cr
        echo
        ;;

    stop)

        echo -n "Disabling G3/G4 level2 backside cache..."
        echo 0 > /proc/sys/kernel/l2cr
        echo
        ;;

    *)
        echo "Usage: $0 {start|stop}"
        exit 1
        ;;
esac


--------------BBD9F0758C7ED78D5920D79C--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
