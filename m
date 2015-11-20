Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 6466E1A0018
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2015 04:08:07 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 BOUET Serge <serge.bouet@c-s.fr>, BARABAN Luc <luc.baraban@c-s.fr>
Subject: Recurring Oops in link_path_walk()
Message-ID: <564F536F.9080109@c-s.fr>
Date: Fri, 20 Nov 2015 18:07:59 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Al,

We've been running Kernel 3.18 for several monthes on our embedded 
boards, and we have a recurring Oops in link_path_walk()
It doesn't happen very often (approximatly once every month on one board 
among a set of 50 boards, never the same board).

Here below is the last oops I got, with kernel 3.18.22. It crashes at 
address 0xc00b75ac. Here below is the full desassembly of 
link_path_walk() so that you can see exactly the offending line.

The address it fails at is always the same (link_path_walk+0x414) but 
the oopsing data address is each time different. I added all Oops I got 
below after the disassembly (on different sub-versions of 3.18).

Do you have any idea of what this can be ? Is there any recent change 
made since 3.18 that could fix it and could be backported into 3.18 ?

Thanks,
Christophe

[10250.855670] Unable to handle kernel paging request for data at 
address 0x00003879
[10250.867593] Faulting instruction address: 0xc00b75ac
[10250.883695] Oops: Kernel access of bad area, sig: 11 [#1]
[10250.888766] PREEMPT CMPC885
[10250.891564] CPU: 0 PID: 2416 Comm: SUO_ Not tainted 3.18.22 #53
[10250.899123] task: c628e680 ti: c66c8000 task.ti: c66c8000
[10250.904451] NIP: c00b75ac LR: c00b7574 CTR: c00fcdc8
[10250.909364] REGS: c66c9d10 TRAP: 0300   Not tainted  (3.18.22)
[10250.916825] MSR: 00009032 <EE,ME,IR,DR,RI>  CR: 22002482 XER: 00000000
[10250.923374] DAR: 00003879 DSISR: c0000000
[10250.923374] GPR00: c00b7574 c66c9dc0 c628e680 c1088330 c50883b8 
c50883f2 90f9ced3 00000031
[10250.923374] GPR08: 00000000 00003869 c5085560 31c52da7 22002482 
101ccd18 101c0000 1017da60
[10250.923374] GPR16: 1024b884 101758d4 1017d9a8 1014e64c 1051553c 
00000000 00000000 c66c8000
[10250.923374] GPR24: 00100000 c66c9ea0 00300000 00000004 fffff000 
c651b02f 00000000 c66c9e88
[10250.955351] NIP [c00b75ac] link_path_walk+0x414/0x86c
[10250.960326] LR [c00b7574] link_path_walk+0x3dc/0x86c
[10250.965191] Call Trace:
[10250.967640] [c66c9dc0] [c00b7574] link_path_walk+0x3dc/0x86c (unreliable)
[10250.974363] [c66c9e20] [c00b9e30] path_openat+0x90/0x678
[10250.979605] [c66c9e80] [c00ba448] do_filp_open+0x30/0x8c
[10250.984857] [c66c9f00] [c00abc08] do_sys_open+0x14c/0x238
[10250.990196] [c66c9f40] [c000b294] ret_from_syscall+0x0/0x38
[10250.995654] Instruction dump:
[10250.998585] 7f834800 419e000c 48014f81 80610018 8081001c 81410020 
907f0000 909f0004
[10251.006243] 915f0020 3bc00000 8061000c 81230028 <81290010> 81290014 
2f890000 419e0014



c00b7198 <link_path_walk>:
  *
  * Returns 0 and nd will have valid dentry and mnt on success.
  * Returns error and drops reference to input namei data on failure.
  */
static int link_path_walk(const char *name, struct nameidata *nd)
{
c00b7198:    7c 08 02 a6     mflr    r0
c00b719c:    94 21 ff a0     stwu    r1,-96(r1)
c00b71a0:    be a1 00 34     stmw    r21,52(r1)
c00b71a4:    90 01 00 64     stw     r0,100(r1)
c00b71a8:    7c 7d 1b 78     mr      r29,r3
     struct path next;
     int err;

     while (*name=='/')
c00b71ac:    89 23 00 00     lbz     r9,0(r3)
  *
  * Returns 0 and nd will have valid dentry and mnt on success.
  * Returns error and drops reference to input namei data on failure.
  */
static int link_path_walk(const char *name, struct nameidata *nd)
{
c00b71b0:    7c 9f 23 78     mr      r31,r4
     struct path next;
     int err;

     while (*name=='/')
c00b71b4:    2b 89 00 2f     cmplwi  cr7,r9,47
c00b71b8:    40 9e 00 10     bne     cr7,c00b71c8 <link_path_walk+0x30>
c00b71bc:    8d 3d 00 01     lbzu    r9,1(r29)
c00b71c0:    2b 89 00 2f     cmplwi  cr7,r9,47
c00b71c4:    41 9e ff f8     beq     cr7,c00b71bc <link_path_walk+0x24>
         name++;
     if (!*name)
c00b71c8:    2f 89 00 00     cmpwi   cr7,r9,0
c00b71cc:    41 9e 02 48     beq     cr7,c00b7414 <link_path_walk+0x27c>
  * so we keep a cache of "no, this doesn't need follow_link"
  * for the common case.
  */
static inline int should_follow_link(struct dentry *dentry, int follow)
{
     return unlikely(d_is_symlink(dentry)) ? follow : 0;
c00b71d0:    3f 40 00 30     lis     r26,48

     error = security_inode_follow_link(link->dentry, nd);
     if (error)
         goto out_put_nd_path;

     nd->last_type = LAST_BIND;
c00b71d4:    3b 60 00 04     li      r27,4
     *p = dentry->d_inode->i_op->follow_link(dentry, nd);
     error = PTR_ERR(*p);
     if (IS_ERR(*p))
c00b71d8:    3b 80 f0 00     li      r28,-4096
     return status;
}

static __always_inline void set_root(struct nameidata *nd)
{
     get_fs_root(current->fs, &nd->root);
c00b71dc:    3b 3f 00 18     addi    r25,r31,24
c00b71e0:    54 37 00 24     rlwinm  r23,r1,0,0,18
         if (err) {
             err = nested_symlink(&next, nd);
             if (err)
                 return err;
         }
         if (!d_can_lookup(nd->path.dentry)) {
c00b71e4:    3f 00 00 10     lis     r24,16
     return 0;
}

static inline int may_lookup(struct nameidata *nd)
{
     if (nd->flags & LOOKUP_RCU) {
c00b71e8:    81 3f 00 24     lwz     r9,36(r31)
c00b71ec:    71 24 00 40     andi.   r4,r9,64
c00b71f0:    40 82 01 a0     bne     c00b7390 <link_path_walk+0x1f8>
         if (err != -ECHILD)
             return err;
         if (unlazy_walk(nd, NULL))
             return -ECHILD;
     }
     return inode_permission(nd->inode, MAY_EXEC);
c00b71f4:    80 7f 00 20     lwz     r3,32(r31)
c00b71f8:    38 80 00 01     li      r4,1
c00b71fc:    4b ff f2 15     bl      c00b6410 <inode_permission>
c00b7200:    7c 7e 1b 78     mr      r30,r3
     for(;;) {
         u64 hash_len;
         int type;

         err = may_lookup(nd);
          if (err)
c00b7204:    2f 9e 00 00     cmpwi   cr7,r30,0
c00b7208:    40 9e 01 1c     bne     cr7,c00b7324 <link_path_walk+0x18c>
static inline u64 hash_name(const char *name)
{
     unsigned long hash = init_name_hash();
     unsigned long len = 0, c;

     c = (unsigned char)*name;
c00b720c:    88 bd 00 00     lbz     r5,0(r29)
  * one character.
  */
static inline u64 hash_name(const char *name)
{
     unsigned long hash = init_name_hash();
     unsigned long len = 0, c;
c00b7210:    39 40 00 00     li      r10,0

     c = (unsigned char)*name;
c00b7214:    7c a9 2b 78     mr      r9,r5
  * We know there's a real path component here of at least
  * one character.
  */
static inline u64 hash_name(const char *name)
{
     unsigned long hash = init_name_hash();
c00b7218:    39 00 00 00     li      r8,0
c00b721c:    48 00 00 08     b       c00b7224 <link_path_walk+0x8c>
     c = (unsigned char)*name;
     do {
         len++;
         hash = partial_name_hash(c, hash);
         c = (unsigned char)name[len];
     } while (c && c != '/');
c00b7220:    41 9a 00 2c     beq     cr6,c00b724c <link_path_walk+0xb4>
     unsigned long hash = init_name_hash();
     unsigned long len = 0, c;

     c = (unsigned char)*name;
     do {
         len++;
c00b7224:    39 4a 00 01     addi    r10,r10,1

/* partial hash update function. Assume roughly 4 bits per character */
static inline unsigned long
partial_name_hash(unsigned long c, unsigned long prevhash)
{
     return (prevhash + (c << 4) + (c >> 4)) * 11;
c00b7228:    55 26 e1 3e     rlwinm  r6,r9,28,4,31
c00b722c:    55 27 20 36     rlwinm  r7,r9,4,0,27
         hash = partial_name_hash(c, hash);
         c = (unsigned char)name[len];
c00b7230:    7d 3d 50 ae     lbzx    r9,r29,r10
c00b7234:    7c e6 3a 14     add     r7,r6,r7
     } while (c && c != '/');
c00b7238:    2f 89 00 00     cmpwi   cr7,r9,0
c00b723c:    7d 07 42 14     add     r8,r7,r8
c00b7240:    2b 09 00 2f     cmplwi  cr6,r9,47
c00b7244:    1d 08 00 0b     mulli   r8,r8,11
c00b7248:    40 9e ff d8     bne     cr7,c00b7220 <link_path_walk+0x88>
             break;

         hash_len = hash_name(name);

         type = LAST_NORM;
         if (name[0] == '.') switch (hashlen_len(hash_len)) {
c00b724c:    2b 85 00 2e     cmplwi  cr7,r5,46
     do {
         len++;
         hash = partial_name_hash(c, hash);
         c = (unsigned char)name[len];
     } while (c && c != '/');
     return hashlen_create(end_name_hash(hash), len);
c00b7250:    7d 47 53 78     mr      r7,r10
c00b7254:    7d 06 43 78     mr      r6,r8
             break;

         hash_len = hash_name(name);

         type = LAST_NORM;
         if (name[0] == '.') switch (hashlen_len(hash_len)) {
c00b7258:    41 9e 01 70     beq     cr7,c00b73c8 <link_path_walk+0x230>
             case 1:
                 type = LAST_DOT;
         }
         if (likely(type == LAST_NORM)) {
             struct dentry *parent = nd->path.dentry;
             nd->flags &= ~LOOKUP_JUMPED;
c00b725c:    80 bf 00 24     lwz     r5,36(r31)
                 break;
             case 1:
                 type = LAST_DOT;
         }
         if (likely(type == LAST_NORM)) {
             struct dentry *parent = nd->path.dentry;
c00b7260:    81 3f 00 04     lwz     r9,4(r31)
             nd->flags &= ~LOOKUP_JUMPED;
c00b7264:    54 a5 05 24     rlwinm  r5,r5,0,20,18
c00b7268:    90 bf 00 24     stw     r5,36(r31)
             if (unlikely(parent->d_flags & DCACHE_OP_HASH)) {
c00b726c:    80 a9 00 00     lwz     r5,0(r9)
c00b7270:    70 a4 00 01     andi.   r4,r5,1
c00b7274:    40 82 02 30     bne     c00b74a4 <link_path_walk+0x30c>
c00b7278:    7d 45 53 78     mr      r5,r10
c00b727c:    39 20 00 00     li      r9,0
                 hash_len = this.hash_len;
                 name = this.name;
             }
         }

         nd->last.hash_len = hash_len;
c00b7280:    90 ff 00 08     stw     r7,8(r31)
c00b7284:    90 df 00 0c     stw     r6,12(r31)
         nd->last.name = name;
c00b7288:    93 bf 00 10     stw     r29,16(r31)
         nd->last_type = type;
c00b728c:    91 3f 00 30     stw     r9,48(r31)

         name += hashlen_len(hash_len);
         if (!*name)
c00b7290:    7d 5d 28 ee     lbzux   r10,r29,r5
c00b7294:    2f 8a 00 00     cmpwi   cr7,r10,0
c00b7298:    41 9e 01 7c     beq     cr7,c00b7414 <link_path_walk+0x27c>
          * If it wasn't NUL, we know it was '/'. Skip that
          * slash, and continue until no more slashes.
          */
         do {
             name++;
         } while (unlikely(*name == '/'));
c00b729c:    8d 5d 00 01     lbzu    r10,1(r29)
c00b72a0:    2b 8a 00 2f     cmplwi  cr7,r10,47
c00b72a4:    41 be ff f8     beq     cr7,c00b729c <link_path_walk+0x104>
         if (!*name)
c00b72a8:    2f 8a 00 00     cmpwi   cr7,r10,0
c00b72ac:    41 9e 01 68     beq     cr7,c00b7414 <link_path_walk+0x27c>
     /*
      * "." and ".." are special - ".." especially so because it has
      * to be able to know about the current root directory and
      * parent relationships.
      */
     if (unlikely(nd->last_type != LAST_NORM))
c00b72b0:    2f 89 00 00     cmpwi   cr7,r9,0
c00b72b4:    40 9e 01 bc     bne     cr7,c00b7470 <link_path_walk+0x2d8>
         return handle_dots(nd, nd->last_type);
     err = lookup_fast(nd, path, &inode);
c00b72b8:    7f e3 fb 78     mr      r3,r31
c00b72bc:    38 81 00 18     addi    r4,r1,24
c00b72c0:    38 a1 00 08     addi    r5,r1,8
c00b72c4:    4b ff f9 69     bl      c00b6c2c <lookup_fast>
     if (unlikely(err)) {
c00b72c8:    7c 7e 1b 79     mr.     r30,r3
c00b72cc:    40 82 06 f8     bne     c00b79c4 <link_path_walk+0x82c>
c00b72d0:    81 41 00 08     lwz     r10,8(r1)
             goto out_err;

         inode = path->dentry->d_inode;
     }
     err = -ENOENT;
     if (!inode || d_is_negative(path->dentry))
c00b72d4:    2f 8a 00 00     cmpwi   cr7,r10,0
c00b72d8:    41 9e 00 6c     beq     cr7,c00b7344 <link_path_walk+0x1ac>
c00b72dc:    80 81 00 1c     lwz     r4,28(r1)
     spin_unlock(&dentry->d_lock);
}

static inline unsigned __d_entry_type(const struct dentry *dentry)
{
     return dentry->d_flags & DCACHE_ENTRY_TYPE;
c00b72e0:    81 24 00 00     lwz     r9,0(r4)
c00b72e4:    75 28 00 70     andis.  r8,r9,112
c00b72e8:    41 82 00 5c     beq     c00b7344 <link_path_walk+0x1ac>
  * so we keep a cache of "no, this doesn't need follow_link"
  * for the common case.
  */
static inline int should_follow_link(struct dentry *dentry, int follow)
{
     return unlikely(d_is_symlink(dentry)) ? follow : 0;
c00b72ec:    7f 88 d0 00     cmpw    cr7,r8,r26
c00b72f0:    41 9e 02 04     beq     cr7,c00b74f4 <link_path_walk+0x35c>
}

static inline void path_to_nameidata(const struct path *path,
                     struct nameidata *nd)
{
     if (!(nd->flags & LOOKUP_RCU)) {
c00b72f4:    81 3f 00 24     lwz     r9,36(r31)
c00b72f8:    71 28 00 40     andi.   r8,r9,64
c00b72fc:    41 82 01 38     beq     c00b7434 <link_path_walk+0x29c>
c00b7300:    81 21 00 18     lwz     r9,24(r1)
         dput(nd->path.dentry);
         if (nd->path.mnt != path->mnt)
             mntput(nd->path.mnt);
     }
     nd->path.mnt = path->mnt;
c00b7304:    91 3f 00 00     stw     r9,0(r31)
     nd->path.dentry = path->dentry;
c00b7308:    90 9f 00 04     stw     r4,4(r31)
         }
         BUG_ON(inode != path->dentry->d_inode);
         return 1;
     }
     path_to_nameidata(path, nd);
     nd->inode = inode;
c00b730c:    91 5f 00 20     stw     r10,32(r31)
c00b7310:    81 24 00 00     lwz     r9,0(r4)
c00b7314:    55 29 02 56     rlwinm  r9,r9,0,9,11
         if (err) {
             err = nested_symlink(&next, nd);
             if (err)
                 return err;
         }
         if (!d_can_lookup(nd->path.dentry)) {
c00b7318:    7f 89 c0 00     cmpw    cr7,r9,r24
c00b731c:    41 9e fe cc     beq     cr7,c00b71e8 <link_path_walk+0x50>
             err = -ENOTDIR;
c00b7320:    3b c0 ff ec     li      r30,-20
             break;
         }
     }
     terminate_walk(nd);
c00b7324:    7f e3 fb 78     mr      r3,r31
c00b7328:    4b ff eb b9     bl      c00b5ee0 <terminate_walk>
     return err;
c00b732c:    7f c3 f3 78     mr      r3,r30
}
c00b7330:    80 01 00 64     lwz     r0,100(r1)
c00b7334:    ba a1 00 34     lmw     r21,52(r1)
c00b7338:    7c 08 03 a6     mtlr    r0
c00b733c:    38 21 00 60     addi    r1,r1,96
c00b7340:    4e 80 00 20     blr
}

static inline void path_to_nameidata(const struct path *path,
                     struct nameidata *nd)
{
     if (!(nd->flags & LOOKUP_RCU)) {
c00b7344:    81 3f 00 24     lwz     r9,36(r31)
c00b7348:    71 28 00 40     andi.   r8,r9,64
c00b734c:    41 82 00 24     beq     c00b7370 <link_path_walk+0x1d8>
c00b7350:    80 61 00 18     lwz     r3,24(r1)
         dput(nd->path.dentry);
         if (nd->path.mnt != path->mnt)
             mntput(nd->path.mnt);
     }
     nd->path.mnt = path->mnt;
     nd->path.dentry = path->dentry;
c00b7354:    81 21 00 1c     lwz     r9,28(r1)
     if (!(nd->flags & LOOKUP_RCU)) {
         dput(nd->path.dentry);
         if (nd->path.mnt != path->mnt)
             mntput(nd->path.mnt);
     }
     nd->path.mnt = path->mnt;
c00b7358:    90 7f 00 00     stw     r3,0(r31)
     nd->path.dentry = path->dentry;
c00b735c:    91 3f 00 04     stw     r9,4(r31)
         if (!d_can_lookup(nd->path.dentry)) {
             err = -ENOTDIR;
             break;
         }
     }
     terminate_walk(nd);
c00b7360:    7f e3 fb 78     mr      r3,r31
         if (err < 0)
             goto out_err;

         inode = path->dentry->d_inode;
     }
     err = -ENOENT;
c00b7364:    3b c0 ff fe     li      r30,-2
         if (!d_can_lookup(nd->path.dentry)) {
             err = -ENOTDIR;
             break;
         }
     }
     terminate_walk(nd);
c00b7368:    4b ff eb 79     bl      c00b5ee0 <terminate_walk>
c00b736c:    4b ff ff c0     b       c00b732c <link_path_walk+0x194>

static inline void path_to_nameidata(const struct path *path,
                     struct nameidata *nd)
{
     if (!(nd->flags & LOOKUP_RCU)) {
         dput(nd->path.dentry);
c00b7370:    80 7f 00 04     lwz     r3,4(r31)
c00b7374:    48 00 b5 89     bl      c00c28fc <dput>
         if (nd->path.mnt != path->mnt)
c00b7378:    80 7f 00 00     lwz     r3,0(r31)
c00b737c:    81 21 00 18     lwz     r9,24(r1)
c00b7380:    7f 83 48 40     cmplw   cr7,r3,r9
c00b7384:    41 be ff d0     beq     cr7,c00b7354 <link_path_walk+0x1bc>
             mntput(nd->path.mnt);
c00b7388:    48 01 51 7d     bl      c00cc504 <mntput>
c00b738c:    4b ff ff c4     b       c00b7350 <link_path_walk+0x1b8>
}

static inline int may_lookup(struct nameidata *nd)
{
     if (nd->flags & LOOKUP_RCU) {
         int err = inode_permission(nd->inode, MAY_EXEC|MAY_NOT_BLOCK);
c00b7390:    80 7f 00 20     lwz     r3,32(r31)
c00b7394:    38 80 00 81     li      r4,129
c00b7398:    4b ff f0 79     bl      c00b6410 <inode_permission>
         if (err != -ECHILD)
c00b739c:    2f 83 ff f6     cmpwi   cr7,r3,-10
}

static inline int may_lookup(struct nameidata *nd)
{
     if (nd->flags & LOOKUP_RCU) {
         int err = inode_permission(nd->inode, MAY_EXEC|MAY_NOT_BLOCK);
c00b73a0:    7c 7e 1b 78     mr      r30,r3
         if (err != -ECHILD)
c00b73a4:    40 9e fe 60     bne     cr7,c00b7204 <link_path_walk+0x6c>
             return err;
         if (unlazy_walk(nd, NULL))
c00b73a8:    7f e3 fb 78     mr      r3,r31
c00b73ac:    38 80 00 00     li      r4,0
c00b73b0:    4b ff f6 c5     bl      c00b6a74 <unlazy_walk>
c00b73b4:    2f 83 00 00     cmpwi   cr7,r3,0
c00b73b8:    41 be fe 3c     beq     cr7,c00b71f4 <link_path_walk+0x5c>
         if (!d_can_lookup(nd->path.dentry)) {
             err = -ENOTDIR;
             break;
         }
     }
     terminate_walk(nd);
c00b73bc:    7f e3 fb 78     mr      r3,r31
c00b73c0:    4b ff eb 21     bl      c00b5ee0 <terminate_walk>
c00b73c4:    4b ff ff 68     b       c00b732c <link_path_walk+0x194>
             break;

         hash_len = hash_name(name);

         type = LAST_NORM;
         if (name[0] == '.') switch (hashlen_len(hash_len)) {
c00b73c8:    2f 8a 00 01     cmpwi   cr7,r10,1
c00b73cc:    7d 45 53 78     mr      r5,r10
c00b73d0:    41 9e 00 5c     beq     cr7,c00b742c <link_path_walk+0x294>
c00b73d4:    2f 8a 00 02     cmpwi   cr7,r10,2
c00b73d8:    40 be fe 84     bne     cr7,c00b725c <link_path_walk+0xc4>
             case 2:
                 if (name[1] == '.') {
c00b73dc:    89 3d 00 01     lbz     r9,1(r29)
c00b73e0:    2f 89 00 2e     cmpwi   cr7,r9,46
c00b73e4:    40 9e fe 78     bne     cr7,c00b725c <link_path_walk+0xc4>
                     type = LAST_DOTDOT;
                     nd->flags |= LOOKUP_JUMPED;
c00b73e8:    81 5f 00 24     lwz     r10,36(r31)

         type = LAST_NORM;
         if (name[0] == '.') switch (hashlen_len(hash_len)) {
             case 2:
                 if (name[1] == '.') {
                     type = LAST_DOTDOT;
c00b73ec:    39 20 00 03     li      r9,3
                     nd->flags |= LOOKUP_JUMPED;
c00b73f0:    61 4a 10 00     ori     r10,r10,4096
c00b73f4:    91 5f 00 24     stw     r10,36(r31)
                 hash_len = this.hash_len;
                 name = this.name;
             }
         }

         nd->last.hash_len = hash_len;
c00b73f8:    90 ff 00 08     stw     r7,8(r31)
c00b73fc:    90 df 00 0c     stw     r6,12(r31)
         nd->last.name = name;
c00b7400:    93 bf 00 10     stw     r29,16(r31)
         nd->last_type = type;
c00b7404:    91 3f 00 30     stw     r9,48(r31)

         name += hashlen_len(hash_len);
         if (!*name)
c00b7408:    7d 5d 28 ee     lbzux   r10,r29,r5
c00b740c:    2f 8a 00 00     cmpwi   cr7,r10,0
c00b7410:    40 9e fe 8c     bne     cr7,c00b729c <link_path_walk+0x104>
             break;
         }
     }
     terminate_walk(nd);
     return err;
}
c00b7414:    80 01 00 64     lwz     r0,100(r1)
c00b7418:    ba a1 00 34     lmw     r21,52(r1)
c00b741c:    7c 08 03 a6     mtlr    r0
     int err;

     while (*name=='/')
         name++;
     if (!*name)
         return 0;
c00b7420:    38 60 00 00     li      r3,0
             break;
         }
     }
     terminate_walk(nd);
     return err;
}
c00b7424:    38 21 00 60     addi    r1,r1,96
c00b7428:    4e 80 00 20     blr
                     type = LAST_DOTDOT;
                     nd->flags |= LOOKUP_JUMPED;
                 }
                 break;
             case 1:
                 type = LAST_DOT;
c00b742c:    39 20 00 02     li      r9,2
c00b7430:    4b ff fe 50     b       c00b7280 <link_path_walk+0xe8>

static inline void path_to_nameidata(const struct path *path,
                     struct nameidata *nd)
{
     if (!(nd->flags & LOOKUP_RCU)) {
         dput(nd->path.dentry);
c00b7434:    80 7f 00 04     lwz     r3,4(r31)
c00b7438:    48 00 b4 c5     bl      c00c28fc <dput>
         if (nd->path.mnt != path->mnt)
c00b743c:    80 7f 00 00     lwz     r3,0(r31)
c00b7440:    81 21 00 18     lwz     r9,24(r1)
c00b7444:    7f 83 48 00     cmpw    cr7,r3,r9
c00b7448:    41 9e 00 18     beq     cr7,c00b7460 <link_path_walk+0x2c8>
             mntput(nd->path.mnt);
c00b744c:    48 01 50 b9     bl      c00cc504 <mntput>
c00b7450:    81 21 00 18     lwz     r9,24(r1)
c00b7454:    80 81 00 1c     lwz     r4,28(r1)
c00b7458:    81 41 00 08     lwz     r10,8(r1)
c00b745c:    4b ff fe a8     b       c00b7304 <link_path_walk+0x16c>
c00b7460:    80 81 00 1c     lwz     r4,28(r1)
c00b7464:    81 41 00 08     lwz     r10,8(r1)
static inline void path_to_nameidata(const struct path *path,
                     struct nameidata *nd)
{
     if (!(nd->flags & LOOKUP_RCU)) {
         dput(nd->path.dentry);
         if (nd->path.mnt != path->mnt)
c00b7468:    7c 69 1b 78     mr      r9,r3
c00b746c:    4b ff fe 98     b       c00b7304 <link_path_walk+0x16c>
     return inode_permission(nd->inode, MAY_EXEC);
}

static inline int handle_dots(struct nameidata *nd, int type)
{
     if (type == LAST_DOTDOT) {
c00b7470:    2f 89 00 03     cmpwi   cr7,r9,3
c00b7474:    41 9e 00 0c     beq     cr7,c00b7480 <link_path_walk+0x2e8>
c00b7478:    80 9f 00 04     lwz     r4,4(r31)
c00b747c:    4b ff fe 94     b       c00b7310 <link_path_walk+0x178>
         if (nd->flags & LOOKUP_RCU) {
c00b7480:    81 3f 00 24     lwz     r9,36(r31)
             if (follow_dotdot_rcu(nd))
c00b7484:    7f e3 fb 78     mr      r3,r31
}

static inline int handle_dots(struct nameidata *nd, int type)
{
     if (type == LAST_DOTDOT) {
         if (nd->flags & LOOKUP_RCU) {
c00b7488:    71 24 00 40     andi.   r4,r9,64
c00b748c:    41 82 00 5c     beq     c00b74e8 <link_path_walk+0x350>
             if (follow_dotdot_rcu(nd))
c00b7490:    4b ff e3 b1     bl      c00b5840 <follow_dotdot_rcu>
c00b7494:    2f 83 00 00     cmpwi   cr7,r3,0
c00b7498:    41 be ff e0     beq     cr7,c00b7478 <link_path_walk+0x2e0>
                 return -ECHILD;
c00b749c:    38 60 ff f6     li      r3,-10
c00b74a0:    4b ff fe 90     b       c00b7330 <link_path_walk+0x198>
         }
         if (likely(type == LAST_NORM)) {
             struct dentry *parent = nd->path.dentry;
             nd->flags &= ~LOOKUP_JUMPED;
             if (unlikely(parent->d_flags & DCACHE_OP_HASH)) {
                 struct qstr this = { { .hash_len = hash_len }, .name = 
name };
c00b74a4:    91 41 00 08     stw     r10,8(r1)
c00b74a8:    91 01 00 0c     stw     r8,12(r1)
c00b74ac:    93 a1 00 10     stw     r29,16(r1)
                 err = parent->d_op->d_hash(parent, &this);
c00b74b0:    7d 23 4b 78     mr      r3,r9
c00b74b4:    81 29 00 58     lwz     r9,88(r9)
c00b74b8:    38 81 00 08     addi    r4,r1,8
c00b74bc:    81 29 00 08     lwz     r9,8(r9)
c00b74c0:    7d 29 03 a6     mtctr   r9
c00b74c4:    4e 80 04 21     bctrl
                 if (err < 0)
c00b74c8:    7c 7e 1b 79     mr.     r30,r3
c00b74cc:    41 a0 fe 58     blt     c00b7324 <link_path_walk+0x18c>
                     break;
                 hash_len = this.hash_len;
c00b74d0:    80 e1 00 08     lwz     r7,8(r1)
c00b74d4:    80 c1 00 0c     lwz     r6,12(r1)
                 name = this.name;
c00b74d8:    83 a1 00 10     lwz     r29,16(r1)
c00b74dc:    7c e5 3b 78     mr      r5,r7
c00b74e0:    39 20 00 00     li      r9,0
c00b74e4:    4b ff fd 9c     b       c00b7280 <link_path_walk+0xe8>
     if (type == LAST_DOTDOT) {
         if (nd->flags & LOOKUP_RCU) {
             if (follow_dotdot_rcu(nd))
                 return -ECHILD;
         } else
             follow_dotdot(nd);
c00b74e8:    4b ff fb 99     bl      c00b7080 <follow_dotdot>
c00b74ec:    80 9f 00 04     lwz     r4,4(r31)
c00b74f0:    4b ff fe 20     b       c00b7310 <link_path_walk+0x178>
     err = -ENOENT;
     if (!inode || d_is_negative(path->dentry))
         goto out_path_put;

     if (should_follow_link(path->dentry, follow)) {
         if (nd->flags & LOOKUP_RCU) {
c00b74f4:    81 3f 00 24     lwz     r9,36(r31)
c00b74f8:    71 28 00 40     andi.   r8,r9,64
c00b74fc:    40 82 03 10     bne     c00b780c <link_path_walk+0x674>
                      unlazy_walk(nd, path->dentry))) {
                 err = -ECHILD;
                 goto out_err;
             }
         }
         BUG_ON(inode != path->dentry->d_inode);
c00b7500:    81 24 00 28     lwz     r9,40(r4)
c00b7504:    7d 49 4a 78     xor     r9,r10,r9
c00b7508:    7d 29 00 34     cntlzw  r9,r9
c00b750c:    55 29 d9 7e     rlwinm  r9,r9,27,5,31
c00b7510:    69 29 00 01     xori    r9,r9,1
c00b7514:    0f 09 00 00     twnei   r9,0
  */
static inline int nested_symlink(struct path *path, struct nameidata *nd)
{
     int res;

     if (unlikely(current->link_count >= MAX_NESTED_LINKS)) {
c00b7518:    81 22 02 88     lwz     r9,648(r2)
c00b751c:    2f 89 00 07     cmpwi   cr7,r9,7
c00b7520:    41 9d 04 88     bgt     cr7,c00b79a8 <link_path_walk+0x810>
         path_put_conditional(path, nd);
         path_put(&nd->path);
         return -ELOOP;
     }
     BUG_ON(nd->depth >= MAX_NESTED_LINKS);
c00b7524:    81 5f 00 34     lwz     r10,52(r31)
c00b7528:    21 2a 00 07     subfic  r9,r10,7
c00b752c:    7d 29 49 10     subfe   r9,r9,r9
c00b7530:    7d 29 00 d0     neg     r9,r9
c00b7534:    0f 09 00 00     twnei   r9,0

     nd->depth++;
c00b7538:    39 4a 00 01     addi    r10,r10,1
c00b753c:    91 5f 00 34     stw     r10,52(r31)
c00b7540:    3a c0 00 00     li      r22,0
     current->link_count++;
c00b7544:    81 42 02 88     lwz     r10,648(r2)
c00b7548:    39 4a 00 01     addi    r10,r10,1
c00b754c:    91 42 02 88     stw     r10,648(r2)
c00b7550:    48 00 00 8c     b       c00b75dc <link_path_walk+0x444>
  * so we keep a cache of "no, this doesn't need follow_link"
  * for the common case.
  */
static inline int should_follow_link(struct dentry *dentry, int follow)
{
     return unlikely(d_is_symlink(dentry)) ? follow : 0;
c00b7554:    7f 88 d0 00     cmpw    cr7,r8,r26
c00b7558:    41 9e 03 d8     beq     cr7,c00b7930 <link_path_walk+0x798>
}

static inline void path_to_nameidata(const struct path *path,
                     struct nameidata *nd)
{
     if (!(nd->flags & LOOKUP_RCU)) {
c00b755c:    81 3f 00 24     lwz     r9,36(r31)
c00b7560:    80 61 00 18     lwz     r3,24(r1)
c00b7564:    71 28 00 40     andi.   r8,r9,64
c00b7568:    40 82 00 2c     bne     c00b7594 <link_path_walk+0x3fc>
         dput(nd->path.dentry);
c00b756c:    80 7f 00 04     lwz     r3,4(r31)
c00b7570:    48 00 b3 8d     bl      c00c28fc <dput>
         if (nd->path.mnt != path->mnt)
c00b7574:    80 7f 00 00     lwz     r3,0(r31)
c00b7578:    81 21 00 18     lwz     r9,24(r1)
c00b757c:    7f 83 48 00     cmpw    cr7,r3,r9
c00b7580:    41 9e 00 0c     beq     cr7,c00b758c <link_path_walk+0x3f4>
             mntput(nd->path.mnt);
c00b7584:    48 01 4f 81     bl      c00cc504 <mntput>
c00b7588:    80 61 00 18     lwz     r3,24(r1)
c00b758c:    80 81 00 1c     lwz     r4,28(r1)
c00b7590:    81 41 00 20     lwz     r10,32(r1)
     }
     nd->path.mnt = path->mnt;
c00b7594:    90 7f 00 00     stw     r3,0(r31)
     nd->path.dentry = path->dentry;
c00b7598:    90 9f 00 04     stw     r4,4(r31)
         }
         BUG_ON(inode != path->dentry->d_inode);
         return 1;
     }
     path_to_nameidata(path, nd);
     nd->inode = inode;
c00b759c:    91 5f 00 20     stw     r10,32(r31)
     return 0;
c00b75a0:    3b c0 00 00     li      r30,0
     nd->flags |= LOOKUP_JUMPED;
}

static inline void put_link(struct nameidata *nd, struct path *link, 
void *cookie)
{
     struct inode *inode = link->dentry->d_inode;
c00b75a4:    80 61 00 0c     lwz     r3,12(r1)
     if (inode->i_op->put_link)
c00b75a8:    81 23 00 28     lwz     r9,40(r3)
==> c00b75ac:    81 29 00 10     lwz     r9,16(r9)
c00b75b0:    81 29 00 14     lwz     r9,20(r9)
c00b75b4:    2f 89 00 00     cmpwi   cr7,r9,0
c00b75b8:    41 9e 00 14     beq     cr7,c00b75cc <link_path_walk+0x434>
         inode->i_op->put_link(link->dentry, nd, cookie);
c00b75bc:    7f e4 fb 78     mr      r4,r31
c00b75c0:    7e a5 ab 78     mr      r5,r21
c00b75c4:    7d 29 03 a6     mtctr   r9
c00b75c8:    4e 80 04 21     bctrl
     path_put(link);
c00b75cc:    38 61 00 08     addi    r3,r1,8
c00b75d0:    4b ff f9 3d     bl      c00b6f0c <path_put>
         res = follow_link(&link, nd, &cookie);
         if (res)
             break;
         res = walk_component(nd, path, LOOKUP_FOLLOW);
         put_link(nd, &link, cookie);
     } while (res > 0);
c00b75d4:    2f 9e 00 01     cmpwi   cr7,r30,1
c00b75d8:    40 9e 01 bc     bne     cr7,c00b7794 <link_path_walk+0x5fc>

     nd->depth++;
     current->link_count++;

     do {
         struct path link = *path;
c00b75dc:    81 21 00 1c     lwz     r9,28(r1)
{
     struct dentry *dentry = link->dentry;
     int error;
     char *s;

     BUG_ON(nd->flags & LOOKUP_RCU);
c00b75e0:    81 5f 00 24     lwz     r10,36(r31)

     nd->depth++;
     current->link_count++;

     do {
         struct path link = *path;
c00b75e4:    81 01 00 18     lwz     r8,24(r1)
c00b75e8:    7d 3e 4b 78     mr      r30,r9
c00b75ec:    91 01 00 08     stw     r8,8(r1)
c00b75f0:    91 21 00 0c     stw     r9,12(r1)
}

static __always_inline int
follow_link(struct path *link, struct nameidata *nd, void **p)
{
     struct dentry *dentry = link->dentry;
c00b75f4:    7d 35 4b 78     mr      r21,r9
     int error;
     char *s;

     BUG_ON(nd->flags & LOOKUP_RCU);
c00b75f8:    55 4a 06 72     rlwinm  r10,r10,0,25,25
c00b75fc:    0f 0a 00 00     twnei   r10,0

     if (link->mnt == nd->path.mnt)
c00b7600:    80 61 00 08     lwz     r3,8(r1)
c00b7604:    81 5f 00 00     lwz     r10,0(r31)
c00b7608:    7f 83 50 00     cmpw    cr7,r3,r10
c00b760c:    41 9e 01 80     beq     cr7,c00b778c <link_path_walk+0x5f4>
         mntget(link->mnt);

     error = -ELOOP;
     if (unlikely(current->total_link_count >= 40))
c00b7610:    81 22 02 8c     lwz     r9,652(r2)
c00b7614:    2f 89 00 27     cmpwi   cr7,r9,39
c00b7618:    41 9d 02 e0     bgt     cr7,c00b78f8 <link_path_walk+0x760>
         goto out_put_nd_path;

     cond_resched();
c00b761c:    48 2e b4 99     bl      c03a2ab4 <_cond_resched>
     current->total_link_count++;
c00b7620:    81 42 02 8c     lwz     r10,652(r2)

     touch_atime(link);
c00b7624:    38 61 00 08     addi    r3,r1,8
     error = -ELOOP;
     if (unlikely(current->total_link_count >= 40))
         goto out_put_nd_path;

     cond_resched();
     current->total_link_count++;
c00b7628:    39 4a 00 01     addi    r10,r10,1
c00b762c:    91 42 02 8c     stw     r10,652(r2)

     touch_atime(link);
c00b7630:    48 01 03 f9     bl      c00c7a28 <touch_atime>
c00b7634:    81 3f 00 34     lwz     r9,52(r31)
     error = security_inode_follow_link(link->dentry, nd);
     if (error)
         goto out_put_nd_path;

     nd->last_type = LAST_BIND;
     *p = dentry->d_inode->i_op->follow_link(dentry, nd);
c00b7638:    7e a3 ab 78     mr      r3,r21
c00b763c:    39 29 00 0c     addi    r9,r9,12
c00b7640:    55 29 10 3a     rlwinm  r9,r9,2,0,29
c00b7644:    7d 3f 4a 14     add     r9,r31,r9
c00b7648:    92 c9 00 08     stw     r22,8(r9)

     error = security_inode_follow_link(link->dentry, nd);
     if (error)
         goto out_put_nd_path;

     nd->last_type = LAST_BIND;
c00b764c:    93 7f 00 30     stw     r27,48(r31)
     *p = dentry->d_inode->i_op->follow_link(dentry, nd);
c00b7650:    7f e4 fb 78     mr      r4,r31
c00b7654:    81 3e 00 28     lwz     r9,40(r30)
c00b7658:    81 29 00 10     lwz     r9,16(r9)
c00b765c:    81 29 00 04     lwz     r9,4(r9)
c00b7660:    7d 29 03 a6     mtctr   r9
c00b7664:    4e 80 04 21     bctrl
     error = PTR_ERR(*p);
     if (IS_ERR(*p))
c00b7668:    7f 83 e0 40     cmplw   cr7,r3,r28
     error = security_inode_follow_link(link->dentry, nd);
     if (error)
         goto out_put_nd_path;

     nd->last_type = LAST_BIND;
     *p = dentry->d_inode->i_op->follow_link(dentry, nd);
c00b766c:    7c 75 1b 78     mr      r21,r3
     error = PTR_ERR(*p);
     if (IS_ERR(*p))
c00b7670:    41 9d 02 a0     bgt     cr7,c00b7910 <link_path_walk+0x778>
}

static inline char *nd_get_link(struct nameidata *nd)
{
     return nd->saved_names[nd->depth];
c00b7674:    81 3f 00 34     lwz     r9,52(r31)
c00b7678:    39 29 00 0c     addi    r9,r9,12
c00b767c:    55 29 10 3a     rlwinm  r9,r9,2,0,29
c00b7680:    7d 3f 4a 14     add     r9,r31,r9
c00b7684:    83 c9 00 08     lwz     r30,8(r9)
         goto out_put_nd_path;

     error = 0;
     s = nd_get_link(nd);
     if (s) {
c00b7688:    2f 9e 00 00     cmpwi   cr7,r30,0
c00b768c:    41 9e 00 38     beq     cr7,c00b76c4 <link_path_walk+0x52c>
         if (unlikely(IS_ERR(s))) {
c00b7690:    7f 9e e0 40     cmplw   cr7,r30,r28
c00b7694:    41 9d 01 b8     bgt     cr7,c00b784c <link_path_walk+0x6b4>
             path_put(&nd->path);
             put_link(nd, link, *p);
             return PTR_ERR(s);
         }
         if (*s == '/') {
c00b7698:    89 3e 00 00     lbz     r9,0(r30)
c00b769c:    2f 89 00 2f     cmpwi   cr7,r9,47
c00b76a0:    41 9e 00 b0     beq     cr7,c00b7750 <link_path_walk+0x5b8>
             path_put(&nd->path);
             nd->path = nd->root;
             path_get(&nd->root);
             nd->flags |= LOOKUP_JUMPED;
         }
         nd->inode = nd->path.dentry->d_inode;
c00b76a4:    81 3f 00 04     lwz     r9,4(r31)
         error = link_path_walk(s, nd);
c00b76a8:    7f c3 f3 78     mr      r3,r30
             path_put(&nd->path);
             nd->path = nd->root;
             path_get(&nd->root);
             nd->flags |= LOOKUP_JUMPED;
         }
         nd->inode = nd->path.dentry->d_inode;
c00b76ac:    81 29 00 28     lwz     r9,40(r9)
         error = link_path_walk(s, nd);
c00b76b0:    7f e4 fb 78     mr      r4,r31
             path_put(&nd->path);
             nd->path = nd->root;
             path_get(&nd->root);
             nd->flags |= LOOKUP_JUMPED;
         }
         nd->inode = nd->path.dentry->d_inode;
c00b76b4:    91 3f 00 20     stw     r9,32(r31)
         error = link_path_walk(s, nd);
c00b76b8:    4b ff fa e1     bl      c00b7198 <link_path_walk>
         if (unlikely(error))
c00b76bc:    7c 7e 1b 79     mr.     r30,r3
c00b76c0:    40 82 01 94     bne     c00b7854 <link_path_walk+0x6bc>
     /*
      * "." and ".." are special - ".." especially so because it has
      * to be able to know about the current root directory and
      * parent relationships.
      */
     if (unlikely(nd->last_type != LAST_NORM))
c00b76c4:    81 3f 00 30     lwz     r9,48(r31)
c00b76c8:    2f 89 00 00     cmpwi   cr7,r9,0
c00b76cc:    40 9e 01 d4     bne     cr7,c00b78a0 <link_path_walk+0x708>
         return handle_dots(nd, nd->last_type);
     err = lookup_fast(nd, path, &inode);
c00b76d0:    7f e3 fb 78     mr      r3,r31
c00b76d4:    38 81 00 18     addi    r4,r1,24
c00b76d8:    38 a1 00 20     addi    r5,r1,32
c00b76dc:    4b ff f5 51     bl      c00b6c2c <lookup_fast>
     if (unlikely(err)) {
c00b76e0:    7c 7e 1b 79     mr.     r30,r3
c00b76e4:    40 82 01 ec     bne     c00b78d0 <link_path_walk+0x738>
c00b76e8:    81 41 00 20     lwz     r10,32(r1)
             goto out_err;

         inode = path->dentry->d_inode;
     }
     err = -ENOENT;
     if (!inode || d_is_negative(path->dentry))
c00b76ec:    2f 8a 00 00     cmpwi   cr7,r10,0
c00b76f0:    41 9e 00 14     beq     cr7,c00b7704 <link_path_walk+0x56c>
c00b76f4:    80 81 00 1c     lwz     r4,28(r1)
c00b76f8:    81 24 00 00     lwz     r9,0(r4)
c00b76fc:    75 28 00 70     andis.  r8,r9,112
c00b7700:    40 a2 fe 54     bne     c00b7554 <link_path_walk+0x3bc>
}

static inline void path_to_nameidata(const struct path *path,
                     struct nameidata *nd)
{
     if (!(nd->flags & LOOKUP_RCU)) {
c00b7704:    81 3f 00 24     lwz     r9,36(r31)
c00b7708:    71 24 00 40     andi.   r4,r9,64
c00b770c:    41 82 00 24     beq     c00b7730 <link_path_walk+0x598>
c00b7710:    80 61 00 18     lwz     r3,24(r1)
         dput(nd->path.dentry);
         if (nd->path.mnt != path->mnt)
             mntput(nd->path.mnt);
     }
     nd->path.mnt = path->mnt;
     nd->path.dentry = path->dentry;
c00b7714:    81 21 00 1c     lwz     r9,28(r1)
     if (!(nd->flags & LOOKUP_RCU)) {
         dput(nd->path.dentry);
         if (nd->path.mnt != path->mnt)
             mntput(nd->path.mnt);
     }
     nd->path.mnt = path->mnt;
c00b7718:    90 7f 00 00     stw     r3,0(r31)
     nd->path.dentry = path->dentry;
c00b771c:    91 3f 00 04     stw     r9,4(r31)
         if (err < 0)
             goto out_err;

         inode = path->dentry->d_inode;
     }
     err = -ENOENT;
c00b7720:    3b c0 ff fe     li      r30,-2
     return 0;

out_path_put:
     path_to_nameidata(path, nd);
out_err:
     terminate_walk(nd);
c00b7724:    7f e3 fb 78     mr      r3,r31
c00b7728:    4b ff e7 b9     bl      c00b5ee0 <terminate_walk>
c00b772c:    4b ff fe 78     b       c00b75a4 <link_path_walk+0x40c>

static inline void path_to_nameidata(const struct path *path,
                     struct nameidata *nd)
{
     if (!(nd->flags & LOOKUP_RCU)) {
         dput(nd->path.dentry);
c00b7730:    80 7f 00 04     lwz     r3,4(r31)
c00b7734:    48 00 b1 c9     bl      c00c28fc <dput>
         if (nd->path.mnt != path->mnt)
c00b7738:    80 7f 00 00     lwz     r3,0(r31)
c00b773c:    81 21 00 18     lwz     r9,24(r1)
c00b7740:    7f 83 48 40     cmplw   cr7,r3,r9
c00b7744:    41 be ff d0     beq     cr7,c00b7714 <link_path_walk+0x57c>
             mntput(nd->path.mnt);
c00b7748:    48 01 4d bd     bl      c00cc504 <mntput>
c00b774c:    4b ff ff c4     b       c00b7710 <link_path_walk+0x578>
             path_put(&nd->path);
             put_link(nd, link, *p);
             return PTR_ERR(s);
         }
         if (*s == '/') {
             if (!nd->root.mnt)
c00b7750:    81 3f 00 18     lwz     r9,24(r31)
c00b7754:    2f 89 00 00     cmpwi   cr7,r9,0
c00b7758:    41 9e 00 64     beq     cr7,c00b77bc <link_path_walk+0x624>
                 set_root(nd);
             path_put(&nd->path);
c00b775c:    7f e3 fb 78     mr      r3,r31
c00b7760:    4b ff f7 ad     bl      c00b6f0c <path_put>
             nd->path = nd->root;
c00b7764:    81 5f 00 18     lwz     r10,24(r31)
c00b7768:    81 7f 00 1c     lwz     r11,28(r31)
c00b776c:    91 5f 00 00     stw     r10,0(r31)
c00b7770:    91 7f 00 04     stw     r11,4(r31)
             path_get(&nd->root);
c00b7774:    7f 23 cb 78     mr      r3,r25
c00b7778:    4b ff ee 21     bl      c00b6598 <path_get>
             nd->flags |= LOOKUP_JUMPED;
c00b777c:    81 3f 00 24     lwz     r9,36(r31)
c00b7780:    61 29 10 00     ori     r9,r9,4096
c00b7784:    91 3f 00 24     stw     r9,36(r31)
c00b7788:    4b ff ff 1c     b       c00b76a4 <link_path_walk+0x50c>
     char *s;

     BUG_ON(nd->flags & LOOKUP_RCU);

     if (link->mnt == nd->path.mnt)
         mntget(link->mnt);
c00b778c:    48 01 4f 9d     bl      c00cc728 <mntget>
c00b7790:    4b ff fe 80     b       c00b7610 <link_path_walk+0x478>
             break;
         res = walk_component(nd, path, LOOKUP_FOLLOW);
         put_link(nd, &link, cookie);
     } while (res > 0);

     current->link_count--;
c00b7794:    81 42 02 88     lwz     r10,648(r2)
         if (err < 0)
             return err;

         if (err) {
             err = nested_symlink(&next, nd);
             if (err)
c00b7798:    2f 9e 00 00     cmpwi   cr7,r30,0
             break;
         res = walk_component(nd, path, LOOKUP_FOLLOW);
         put_link(nd, &link, cookie);
     } while (res > 0);

     current->link_count--;
c00b779c:    39 4a ff ff     addi    r10,r10,-1
c00b77a0:    91 42 02 88     stw     r10,648(r2)
     nd->depth--;
c00b77a4:    81 3f 00 34     lwz     r9,52(r31)
c00b77a8:    39 29 ff ff     addi    r9,r9,-1
c00b77ac:    91 3f 00 34     stw     r9,52(r31)
         if (err < 0)
             return err;

         if (err) {
             err = nested_symlink(&next, nd);
             if (err)
c00b77b0:    40 be fb 7c     bne     cr7,c00b732c <link_path_walk+0x194>
c00b77b4:    80 9f 00 04     lwz     r4,4(r31)
c00b77b8:    4b ff fb 58     b       c00b7310 <link_path_walk+0x178>
  * The various preempt_count add/sub methods
  */

static __always_inline void __preempt_count_add(int val)
{
     *preempt_count_ptr() += val;
c00b77bc:    81 37 00 0c     lwz     r9,12(r23)
     return status;
}

static __always_inline void set_root(struct nameidata *nd)
{
     get_fs_root(current->fs, &nd->root);
c00b77c0:    81 42 03 f0     lwz     r10,1008(r2)
c00b77c4:    39 29 00 01     addi    r9,r9,1
c00b77c8:    91 37 00 0c     stw     r9,12(r23)
extern int unshare_fs_struct(void);

static inline void get_fs_root(struct fs_struct *fs, struct path *root)
{
     spin_lock(&fs->lock);
     *root = fs->root;
c00b77cc:    81 6a 00 14     lwz     r11,20(r10)
c00b77d0:    81 4a 00 10     lwz     r10,16(r10)
c00b77d4:    91 7f 00 1c     stw     r11,28(r31)
c00b77d8:    91 5f 00 18     stw     r10,24(r31)
     path_get(root);
c00b77dc:    7f 23 cb 78     mr      r3,r25
c00b77e0:    4b ff ed b9     bl      c00b6598 <path_get>
     /*
      * Because of load-store architectures cannot do per-cpu atomic
      * operations; we cannot use PREEMPT_NEED_RESCHED because it might get
      * lost.
      */
     return !--*preempt_count_ptr() && tif_need_resched();
c00b77e4:    81 37 00 0c     lwz     r9,12(r23)
c00b77e8:    39 29 ff ff     addi    r9,r9,-1
c00b77ec:    2f 89 00 00     cmpwi   cr7,r9,0
c00b77f0:    91 37 00 0c     stw     r9,12(r23)
c00b77f4:    40 be ff 68     bne     cr7,c00b775c <link_path_walk+0x5c4>
c00b77f8:    81 37 00 4c     lwz     r9,76(r23)
c00b77fc:    71 24 00 04     andi.   r4,r9,4
c00b7800:    41 a2 ff 5c     beq     c00b775c <link_path_walk+0x5c4>
c00b7804:    48 2e ac b5     bl      c03a24b8 <preempt_schedule>
c00b7808:    4b ff ff 54     b       c00b775c <link_path_walk+0x5c4>
     if (!inode || d_is_negative(path->dentry))
         goto out_path_put;

     if (should_follow_link(path->dentry, follow)) {
         if (nd->flags & LOOKUP_RCU) {
             if (unlikely(nd->path.mnt != path->mnt ||
c00b780c:    81 5f 00 00     lwz     r10,0(r31)
c00b7810:    81 21 00 18     lwz     r9,24(r1)
c00b7814:    7f 8a 48 00     cmpw    cr7,r10,r9
c00b7818:    40 9e 01 d4     bne     cr7,c00b79ec <link_path_walk+0x854>
c00b781c:    7f e3 fb 78     mr      r3,r31
c00b7820:    4b ff f2 55     bl      c00b6a74 <unlazy_walk>
c00b7824:    2f 83 00 00     cmpwi   cr7,r3,0
c00b7828:    40 9e 01 c4     bne     cr7,c00b79ec <link_path_walk+0x854>
                      unlazy_walk(nd, path->dentry))) {
                 err = -ECHILD;
                 goto out_err;
             }
         }
         BUG_ON(inode != path->dentry->d_inode);
c00b782c:    81 21 00 1c     lwz     r9,28(r1)
c00b7830:    81 49 00 28     lwz     r10,40(r9)
c00b7834:    81 21 00 08     lwz     r9,8(r1)
c00b7838:    7d 49 4a 78     xor     r9,r10,r9
c00b783c:    7d 29 00 34     cntlzw  r9,r9
c00b7840:    55 29 d9 7e     rlwinm  r9,r9,27,5,31
c00b7844:    69 29 00 01     xori    r9,r9,1
c00b7848:    4b ff fc cc     b       c00b7514 <link_path_walk+0x37c>

     error = 0;
     s = nd_get_link(nd);
     if (s) {
         if (unlikely(IS_ERR(s))) {
             path_put(&nd->path);
c00b784c:    7f e3 fb 78     mr      r3,r31
c00b7850:    4b ff f6 bd     bl      c00b6f0c <path_put>
     nd->flags |= LOOKUP_JUMPED;
}

static inline void put_link(struct nameidata *nd, struct path *link, 
void *cookie)
{
     struct inode *inode = link->dentry->d_inode;
c00b7854:    80 61 00 0c     lwz     r3,12(r1)
     if (inode->i_op->put_link)
c00b7858:    81 23 00 28     lwz     r9,40(r3)
c00b785c:    81 29 00 10     lwz     r9,16(r9)
c00b7860:    81 29 00 14     lwz     r9,20(r9)
c00b7864:    2f 89 00 00     cmpwi   cr7,r9,0
c00b7868:    41 9e 00 14     beq     cr7,c00b787c <link_path_walk+0x6e4>
         inode->i_op->put_link(link->dentry, nd, cookie);
c00b786c:    7f e4 fb 78     mr      r4,r31
c00b7870:    7e a5 ab 78     mr      r5,r21
c00b7874:    7d 29 03 a6     mtctr   r9
c00b7878:    4e 80 04 21     bctrl
     path_put(link);
c00b787c:    38 61 00 08     addi    r3,r1,8
c00b7880:    4b ff f6 8d     bl      c00b6f0c <path_put>
             break;
         res = walk_component(nd, path, LOOKUP_FOLLOW);
         put_link(nd, &link, cookie);
     } while (res > 0);

     current->link_count--;
c00b7884:    81 42 02 88     lwz     r10,648(r2)
c00b7888:    39 4a ff ff     addi    r10,r10,-1
c00b788c:    91 42 02 88     stw     r10,648(r2)
     nd->depth--;
c00b7890:    81 3f 00 34     lwz     r9,52(r31)
c00b7894:    39 29 ff ff     addi    r9,r9,-1
c00b7898:    91 3f 00 34     stw     r9,52(r31)
c00b789c:    4b ff fa 90     b       c00b732c <link_path_walk+0x194>
     return inode_permission(nd->inode, MAY_EXEC);
}

static inline int handle_dots(struct nameidata *nd, int type)
{
     if (type == LAST_DOTDOT) {
c00b78a0:    2f 89 00 03     cmpwi   cr7,r9,3
c00b78a4:    40 9e 01 50     bne     cr7,c00b79f4 <link_path_walk+0x85c>
         if (nd->flags & LOOKUP_RCU) {
c00b78a8:    81 3f 00 24     lwz     r9,36(r31)
             if (follow_dotdot_rcu(nd))
c00b78ac:    7f e3 fb 78     mr      r3,r31
}

static inline int handle_dots(struct nameidata *nd, int type)
{
     if (type == LAST_DOTDOT) {
         if (nd->flags & LOOKUP_RCU) {
c00b78b0:    71 24 00 40     andi.   r4,r9,64
c00b78b4:    41 82 00 e8     beq     c00b799c <link_path_walk+0x804>
             if (follow_dotdot_rcu(nd))
c00b78b8:    4b ff df 89     bl      c00b5840 <follow_dotdot_rcu>
                 return -ECHILD;
c00b78bc:    30 63 ff ff     addic   r3,r3,-1
c00b78c0:    7c 63 19 10     subfe   r3,r3,r3
c00b78c4:    70 7e 00 0a     andi.   r30,r3,10
c00b78c8:    3b de ff f6     addi    r30,r30,-10
c00b78cc:    4b ff fc d8     b       c00b75a4 <link_path_walk+0x40c>
      */
     if (unlikely(nd->last_type != LAST_NORM))
         return handle_dots(nd, nd->last_type);
     err = lookup_fast(nd, path, &inode);
     if (unlikely(err)) {
         if (err < 0)
c00b78d0:    41 a0 fe 54     blt     c00b7724 <link_path_walk+0x58c>
             goto out_err;

         err = lookup_slow(nd, path);
c00b78d4:    7f e3 fb 78     mr      r3,r31
c00b78d8:    38 81 00 18     addi    r4,r1,24
c00b78dc:    4b ff e5 21     bl      c00b5dfc <lookup_slow>
         if (err < 0)
c00b78e0:    7c 7e 1b 79     mr.     r30,r3
c00b78e4:    41 a0 fe 40     blt     c00b7724 <link_path_walk+0x58c>
             goto out_err;

         inode = path->dentry->d_inode;
c00b78e8:    81 21 00 1c     lwz     r9,28(r1)
c00b78ec:    81 49 00 28     lwz     r10,40(r9)
c00b78f0:    91 41 00 20     stw     r10,32(r1)
c00b78f4:    4b ff fd f8     b       c00b76ec <link_path_walk+0x554>

     return error;

out_put_nd_path:
     *p = NULL;
     path_put(&nd->path);
c00b78f8:    7f e3 fb 78     mr      r3,r31
c00b78fc:    4b ff f6 11     bl      c00b6f0c <path_put>
     path_put(link);
c00b7900:    38 61 00 08     addi    r3,r1,8
c00b7904:    4b ff f6 09     bl      c00b6f0c <path_put>
     BUG_ON(nd->flags & LOOKUP_RCU);

     if (link->mnt == nd->path.mnt)
         mntget(link->mnt);

     error = -ELOOP;
c00b7908:    3b c0 ff d8     li      r30,-40
c00b790c:    4b ff ff 78     b       c00b7884 <link_path_walk+0x6ec>

     return error;

out_put_nd_path:
     *p = NULL;
     path_put(&nd->path);
c00b7910:    7f e3 fb 78     mr      r3,r31
c00b7914:    4b ff f5 f9     bl      c00b6f0c <path_put>
     path_put(link);
c00b7918:    38 61 00 08     addi    r3,r1,8
c00b791c:    4b ff f5 f1     bl      c00b6f0c <path_put>
     do {
         struct path link = *path;
         void *cookie;

         res = follow_link(&link, nd, &cookie);
         if (res)
c00b7920:    2f 95 00 00     cmpwi   cr7,r21,0
}

static inline long __must_check PTR_ERR(__force const void *ptr)
{
     return (long) ptr;
c00b7924:    7e be ab 78     mr      r30,r21
c00b7928:    40 9e ff 5c     bne     cr7,c00b7884 <link_path_walk+0x6ec>
c00b792c:    4b ff fd 98     b       c00b76c4 <link_path_walk+0x52c>
     err = -ENOENT;
     if (!inode || d_is_negative(path->dentry))
         goto out_path_put;

     if (should_follow_link(path->dentry, follow)) {
         if (nd->flags & LOOKUP_RCU) {
c00b7930:    81 3f 00 24     lwz     r9,36(r31)
c00b7934:    71 28 00 40     andi.   r8,r9,64
c00b7938:    40 82 00 24     bne     c00b795c <link_path_walk+0x7c4>
                      unlazy_walk(nd, path->dentry))) {
                 err = -ECHILD;
                 goto out_err;
             }
         }
         BUG_ON(inode != path->dentry->d_inode);
c00b793c:    81 24 00 28     lwz     r9,40(r4)
c00b7940:    7d 49 4a 78     xor     r9,r10,r9
c00b7944:    7d 29 00 34     cntlzw  r9,r9
c00b7948:    55 29 d9 7e     rlwinm  r9,r9,27,5,31
c00b794c:    69 29 00 01     xori    r9,r9,1
c00b7950:    0f 09 00 00     twnei   r9,0
         return 1;
c00b7954:    3b c0 00 01     li      r30,1
c00b7958:    4b ff fc 4c     b       c00b75a4 <link_path_walk+0x40c>
     if (!inode || d_is_negative(path->dentry))
         goto out_path_put;

     if (should_follow_link(path->dentry, follow)) {
         if (nd->flags & LOOKUP_RCU) {
             if (unlikely(nd->path.mnt != path->mnt ||
c00b795c:    81 5f 00 00     lwz     r10,0(r31)
c00b7960:    81 21 00 18     lwz     r9,24(r1)
c00b7964:    7f 8a 48 00     cmpw    cr7,r10,r9
c00b7968:    40 9e 00 94     bne     cr7,c00b79fc <link_path_walk+0x864>
c00b796c:    7f e3 fb 78     mr      r3,r31
c00b7970:    4b ff f1 05     bl      c00b6a74 <unlazy_walk>
c00b7974:    2f 83 00 00     cmpwi   cr7,r3,0
c00b7978:    40 9e 00 84     bne     cr7,c00b79fc <link_path_walk+0x864>
                      unlazy_walk(nd, path->dentry))) {
                 err = -ECHILD;
                 goto out_err;
             }
         }
         BUG_ON(inode != path->dentry->d_inode);
c00b797c:    81 21 00 1c     lwz     r9,28(r1)
c00b7980:    81 49 00 28     lwz     r10,40(r9)
c00b7984:    81 21 00 20     lwz     r9,32(r1)
c00b7988:    7d 49 4a 78     xor     r9,r10,r9
c00b798c:    7d 29 00 34     cntlzw  r9,r9
c00b7990:    55 29 d9 7e     rlwinm  r9,r9,27,5,31
c00b7994:    69 29 00 01     xori    r9,r9,1
c00b7998:    4b ff ff b8     b       c00b7950 <link_path_walk+0x7b8>
     if (type == LAST_DOTDOT) {
         if (nd->flags & LOOKUP_RCU) {
             if (follow_dotdot_rcu(nd))
                 return -ECHILD;
         } else
             follow_dotdot(nd);
c00b799c:    4b ff f6 e5     bl      c00b7080 <follow_dotdot>
     }
     return 0;
c00b79a0:    3b c0 00 00     li      r30,0
c00b79a4:    4b ff fc 00     b       c00b75a4 <link_path_walk+0x40c>
static inline int nested_symlink(struct path *path, struct nameidata *nd)
{
     int res;

     if (unlikely(current->link_count >= MAX_NESTED_LINKS)) {
         path_put_conditional(path, nd);
c00b79a8:    7f e4 fb 78     mr      r4,r31
c00b79ac:    38 61 00 18     addi    r3,r1,24
c00b79b0:    4b ff e3 f5     bl      c00b5da4 <path_put_conditional.isra.50>
         path_put(&nd->path);
c00b79b4:    7f e3 fb 78     mr      r3,r31
c00b79b8:    4b ff f5 55     bl      c00b6f0c <path_put>
         return -ELOOP;
c00b79bc:    38 60 ff d8     li      r3,-40
c00b79c0:    4b ff f9 70     b       c00b7330 <link_path_walk+0x198>
      */
     if (unlikely(nd->last_type != LAST_NORM))
         return handle_dots(nd, nd->last_type);
     err = lookup_fast(nd, path, &inode);
     if (unlikely(err)) {
         if (err < 0)
c00b79c4:    41 a0 f9 60     blt     c00b7324 <link_path_walk+0x18c>
             goto out_err;

         err = lookup_slow(nd, path);
c00b79c8:    7f e3 fb 78     mr      r3,r31
c00b79cc:    38 81 00 18     addi    r4,r1,24
c00b79d0:    4b ff e4 2d     bl      c00b5dfc <lookup_slow>
         if (err < 0)
c00b79d4:    7c 7e 1b 79     mr.     r30,r3
c00b79d8:    41 a0 f9 4c     blt     c00b7324 <link_path_walk+0x18c>
             goto out_err;

         inode = path->dentry->d_inode;
c00b79dc:    81 21 00 1c     lwz     r9,28(r1)
c00b79e0:    81 49 00 28     lwz     r10,40(r9)
c00b79e4:    91 41 00 08     stw     r10,8(r1)
c00b79e8:    4b ff f8 ec     b       c00b72d4 <link_path_walk+0x13c>

     if (should_follow_link(path->dentry, follow)) {
         if (nd->flags & LOOKUP_RCU) {
             if (unlikely(nd->path.mnt != path->mnt ||
                      unlazy_walk(nd, path->dentry))) {
                 err = -ECHILD;
c00b79ec:    3b c0 ff f6     li      r30,-10
c00b79f0:    4b ff f9 34     b       c00b7324 <link_path_walk+0x18c>
             if (follow_dotdot_rcu(nd))
                 return -ECHILD;
         } else
             follow_dotdot(nd);
     }
     return 0;
c00b79f4:    3b c0 00 00     li      r30,0
c00b79f8:    4b ff fb ac     b       c00b75a4 <link_path_walk+0x40c>

     if (should_follow_link(path->dentry, follow)) {
         if (nd->flags & LOOKUP_RCU) {
             if (unlikely(nd->path.mnt != path->mnt ||
                      unlazy_walk(nd, path->dentry))) {
                 err = -ECHILD;
c00b79fc:    3b c0 ff f6     li      r30,-10
c00b7a00:    4b ff fd 24     b       c00b7724 <link_path_walk+0x58c>


[59685.968909] Unable to handle kernel paging request for data at 
address 0x4f5f5079
[59685.981479] Faulting instruction address: 0xc00b74ec
[59685.990902] Oops: Kernel access of bad area, sig: 11 [#1]
[59685.996037] PREEMPT CMPC885
[59685.998833] CPU: 0 PID: 1019 Comm: SUO_ Not tainted 3.18.20 #49
[59686.006392] task: c66789a0 ti: c6456000 task.ti: c6456000
[59686.011719] NIP: c00b74ec LR: c00b74b4 CTR: c00fcc94
[59686.016631] REGS: c6457d10 TRAP: 0300   Not tainted  (3.18.20)
[59686.024098] MSR: 00009032 <EE,ME,IR,DR,RI>  CR: 22002482 XER: 00000000
[59686.030644] DAR: 4f5f5079 DSISR: c0000000
[59686.030644] GPR00: c00b74b4 c6457dc0 c66789a0 c105b410 c505b498 
c505b4d2 90f9ced3 00000031
[59686.030644] GPR08: 00000000 4f5f5069 c50605a0 227406f5 22002482 
101baac0 101b0000 1017b6d8
[59686.030644] GPR16: 1023961c 1017354c 1017b620 1014c608 10503284 
00000000 00000000 c6456000
[59686.030644] GPR24: 00100000 c6457ea0 00300000 00000004 fffff000 
c63fb02f 00000000 c6457e88
[59686.062616] NIP [c00b74ec] link_path_walk+0x414/0x86c
[59686.067595] LR [c00b74b4] link_path_walk+0x3dc/0x86c
[59686.072462] Call Trace:
[59686.074910] [c6457dc0] [c00b74b4] link_path_walk+0x3dc/0x86c (unreliable)
[59686.081627] [c6457e20] [c00b9d70] path_openat+0x90/0x678
[59686.086873] [c6457e80] [c00ba388] do_filp_open+0x30/0x8c
[59686.092128] [c6457f00] [c00abb48] do_sys_open+0x14c/0x238
[59686.097466] [c6457f40] [c000b294] ret_from_syscall+0x0/0x38
[59686.102923] Instruction dump:
[59686.105853] 7f834800 419e000c 48014f75 80610018 8081001c 81410020 
907f0000 909f0004
[59686.113513] 915f0020 3bc00000 8061000c 81230028 <81290010> 81290014 
2f890000 419e0014

[214067.708785] Unable to handle kernel paging request for data at 
address 0x93a10024
[214067.716082] Faulting instruction address: 0xc00b7350
[214067.721082] Oops: Kernel access of bad area, sig: 11 [#1]
[214067.726477] PREEMPT CMPC885
[214067.729360] CPU: 0 PID: 1021 Comm: SUO_ Not tainted 3.18.14 #43
[214067.737006] task: c6600e70 ti: c653e000 task.ti: c653e000
[214067.742420] NIP: c00b7350 LR: c00b7318 CTR: c00fcb04
[214067.747418] REGS: c653fd10 TRAP: 0300   Not tainted  (3.18.14)
[214067.754969] MSR: 00009032 <EE,ME,IR,DR,RI>  CR: 22002482 XER: 00000000
[214067.761608] DAR: 93a10024 DSISR: c0000000
[214067.761608] GPR00: c00b7318 c653fdc0 c6600e70 c105ac18 c505aca0 
c505acda 90f9ced3 00000031
[214067.761608] GPR08: 00000000 93a10014 c5060360 39d5d053 22002482 
101cae54 1017c030 105103ec
[214067.761608] GPR16: 101c0c38 00000003 10510120 1017c248 10239598 
00000000 00000000 c653e000
[214067.761608] GPR24: 00100000 c653fea0 00300000 00000004 fffff000 
c65f302f 00000000 c653fe88
[214067.793667] NIP [c00b7350] link_path_walk+0x414/0x86c
[214067.798730] LR [c00b7318] link_path_walk+0x3dc/0x86c
[214067.803681] Call Trace:
[214067.806219] [c653fdc0] [c00b7318] link_path_walk+0x3dc/0x86c 
(unreliable)
[214067.813017] [c653fe20] [c00b9bd4] path_openat+0x90/0x678
[214067.818352] [c653fe80] [c00ba1ec] do_filp_open+0x30/0x8c
[214067.823694] [c653ff00] [c00ab9ac] do_sys_open+0x14c/0x238
[214067.829120] [c653ff40] [c000b27c] ret_from_syscall+0x0/0x38
[214067.834658] Instruction dump:
[214067.837675] 7f834800 419e000c 48014fb5 80610018 8081001c 81410020 
907f0000 909f0004
[214067.845418] 915f0020 3bc00000 8061000c 81230028 <81290010> 81290014 
2f890000 419e0014
[214067.853353] ---[ end trace 78a545fb58576151 ]---

[205816.678044] Unable to handle kernel paging request for data at 
address 0x20202030
[205816.688395] Faulting instruction address: 0xc00b74ec
[205816.693912] Oops: Kernel access of bad area, sig: 11 [#1]
[205816.699098] PREEMPT CMPC885
[205816.701980] CPU: 0 PID: 1009 Comm: GVC_ Not tainted 3.18.20 #49
[205816.709627] task: c6655810 ti: c66b0000 task.ti: c66b0000
[205816.715038] NIP: c00b74ec LR: c00b74b4 CTR: c00fcc94
[205816.720037] REGS: c66b1d10 TRAP: 0300 Not tainted (3.18.20)
[205816.727589] MSR: 00009032 <EE,ME,IR,DR,RI> CR: 22002482 XER: 00000000
[205816.734221] DAR: 20202030 DSISR: c0000000
[205816.734221] GPR00: c00b74b4 c66b1dc0 c6655810 c105b388 c505b410 
c505b44b 3ac16eed 00000032
[205816.734221] GPR08: 00000000 20202020 c5061680 0e505267 22002482 
101baac0 00000000 1015a584
[205816.734221] GPR16: 1015a4ec 1015a56c 101b0508 101b08a4 10159f88 
00000000 00000000 c66b0000
[205816.734221] GPR24: 00100000 c66b1ea0 00300000 00000004 fffff000 
c6479030 00000000 c66b1e88
[205816.766277] NIP [c00b74ec] link_path_walk+0x414/0x86c
[205816.771343] LR [c00b74b4] link_path_walk+0x3dc/0x86c
[205816.776299] Call Trace:
[205816.778832] [c66b1dc0] [c00b74b4] link_path_walk+0x3dc/0x86c 
(unreliable)
[205816.785636] [c66b1e20] [c00b9d70] path_openat+0x90/0x678
[205816.790967] [c66b1e80] [c00ba388] do_filp_open+0x30/0x8c
[205816.796304] [c66b1f00] [c00abb48] do_sys_open+0x14c/0x238
[205816.801733] [c66b1f40] [c000b294] ret_from_syscall+0x0/0x38
[205816.807275] Instruction dump:
[205816.810292] 7f834800 419e000c 48014f75 80610018 8081001c 81410020 
907f0000 909f0004
[205816.818038] 915f0020 3bc00000 8061000c 81230028 <81290010> 81290014 
2f890000 419e0014

[219713.431174] Unable to handle kernel paging request for data at 
address 0x6e3d227e
[219713.438912] Faulting instruction address: 0xc00b7350
[219713.445717] Oops: Kernel access of bad area, sig: 11 [#1]
[219713.450862] PREEMPT CMPC885
[219713.453744] CPU: 0 PID: 1016 Comm: SUO_ Not tainted 3.18.14 #43
[219713.461390] task: c66b0e70 ti: c66ec000 task.ti: c66ec000
[219713.466803] NIP: c00b7350 LR: c00b7318 CTR: c00fcb04
[219713.471801] REGS: c66edd10 TRAP: 0300   Not tainted  (3.18.14)
[219713.479352] MSR: 00009032 <EE,ME,IR,DR,RI>  CR: 22002482 XER: 00000000
[219713.485989] DAR: 6e3d227e DSISR: c0000000
[219713.485989] GPR00: c00b7318 c66eddc0 c66b0e70 c105ab08 c505ab90 
c505abca 90f9ced3 00000031
[219713.485989] GPR08: 00000000 6e3d226e c5060360 0d2c06ce 22002482 
101cae54 1017c030 105103ec
[219713.485989] GPR16: 101c0c38 00000003 10510120 1017c248 10239598 
00000000 00000000 c66ec000
[219713.485989] GPR24: 00100000 c66edea0 00300000 00000004 fffff000 
c63f802f 00000000 c66ede88
[219713.518053] NIP [c00b7350] link_path_walk+0x414/0x86c
[219713.523116] LR [c00b7318] link_path_walk+0x3dc/0x86c
[219713.528067] Call Trace:
[219713.530601] [c66eddc0] [c00b7318] link_path_walk+0x3dc/0x86c 
(unreliable)
[219713.537401] [c66ede20] [c00b9bd4] path_openat+0x90/0x678
[219713.542735] [c66ede80] [c00ba1ec] do_filp_open+0x30/0x8c
[219713.548078] [c66edf00] [c00ab9ac] do_sys_open+0x14c/0x238
[219713.553503] [c66edf40] [c000b27c] ret_from_syscall+0x0/0x38
[219713.559041] Instruction dump:
[219713.562058] 7f834800 419e000c 48014fb5 80610018 8081001c 81410020 
907f0000 909f0004
[219713.569801] 915f0020 3bc00000 8061000c 81230028 <81290010> 81290014 
2f890000 419e0014
