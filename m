Message-Id: <200004062001.QAA88680@p2.parker.boston.ma.us>
To: linuxppc-embedded@lists.linuxppc.org
Subject: nfsroot and the latest 2.3.99-prexxx?
Date: Thu, 06 Apr 2000 16:01:04 -0400
From: Brad Parker <brad@parker.boston.ma.us>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm not sure what to do with this, so here goes:

I was trying to boot the latest 2.3.99-pre4 this morning using an nfs
root.  It crashed and I found what looks like a glaring mistake in
the nfs xdr code...  It wasn't this way in 2.3.47, so it's something
recently introduced (perhaps as part of the nfs v3 work?).

I was curious if anyone else had seen this or was on the main kernel
list and saw something about it.  The original memset wipes out
the file handle pointer (res->fh) and is pretty clearly wrong.

this does not seem to affect the normal nfs client code - I believe
it only is used in the case of a 'diskless' nfs root.

My sense is they really wanted to pre-zero the file handle as it
has some areas unused by nfs v2 which can confuse the new v3 code.

-brad

===== mount_clnt.c 1.2 vs edited =====
--- 1.2/fs/nfs/mount_clnt.c	Sun Apr  2 18:40:21 2000
+++ edited/mount_clnt.c	Thu Apr  6 11:52:33 2000
@@ -120,7 +120,7 @@
 static int
 xdr_decode_fhstatus(struct rpc_rqst *req, u32 *p, struct mnt_fhstatus *res)
 {
-	memset((u8 *)res, 0, sizeof(*res));
+	memset((u8 *)res->fh, 0, sizeof(res->fh));
 	if ((res->status = ntohl(*p++)) == 0) {
 		res->fh->size = NFS2_FHSIZE;
 		memcpy(res->fh->data, p, NFS2_FHSIZE);
@@ -131,7 +131,7 @@
 static int
 xdr_decode_fhstatus3(struct rpc_rqst *req, u32 *p, struct mnt_fhstatus *res)
 {
-	memset((u8 *)res, 0, sizeof(*res));
+	memset((u8 *)res->fh, 0, sizeof(res->fh));
 	if ((res->status = ntohl(*p++)) == 0) {
 		int size = ntohl(*p++);
 		if (size <= NFS3_FHSIZE) {

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
