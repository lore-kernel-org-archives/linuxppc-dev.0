Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3BD83F82.BE5C66A5@disca.upv.es>
Date: Thu, 25 Oct 2001 18:36:18 +0200
From: David de =?iso-8859-1?Q?Andr=E9s=20Mart=EDnez?= <ddandres@disca.upv.es>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Root-NFS: Server returned error -13
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I'm trying to boot from NFS but I can't access the directory.
The NFS server is torreta (158.42.50.79)
The client is stk823L (158.42.50.66)

Here is the error message:
....
Looking up port of RPC 100003/2 on 158.42.50.79
Looking up port of RPC 100005/2 on 158.42.50.79
Root-NFS: Server returned error -13 while mounting
/tftpboot/158.42.50.66
VFS: Unable to mount root fs via NFS, trying floppy
....

The server shows the following /var/log/messages:
....
torreta mountd[20966]: NFS mount of /tftpboot/158.42.50.66 attempted
from 158.42.50.66
torreta mountd[20966]: NFS client stk823L.disca.upv.es tried to access
/tftpboot/158.42.50.66
torreta mountd[20966]: Blocked attempt of 158.42.50.66 to mount
/tftpboot/158.42.50.66
....

The /etc/exports looks like:
....
/home/ddandres/export 158.42.50.66(rw,no_root_squash)
....

The /etc/hosts is:
127.0.0.1	localhost
158.42.50.79	torreta.disca.upv.es	torreta
158.42.50.66	stk823l.disca.upv.es	stk823L

The "rpcinfo -p" command sais:
   program vers proto   port
    100000    2   tcp    111  portmapper
    100000    2   udp    111  portmapper
    100005    1   udp    791  mountd
    100005    2   udp    791  mountd
    100005    1   tcp    794  mountd
    100005    2   tcp    794  mountd
    100003    2   udp   2049  nfs
    100003    2   tcp   2049  nfs
    100021    1   udp   1072  nlockmgr
    100021    3   udp   1072  nlockmgr
    100021    1   tcp   1579  nlockmgr
    100021    3   tcp   1579  nlockmgr

Can anyone guess which is the problem?

--
----------------------------------------------------------------------
| David de Andrés Martínez   | Fault Tolerant Systems research Group |
|                            |                                       |
| Computer Science Engineer  | Email: ddandres@disca.upv.es          |
| Doctorate Student          | Phone: +34 96 387.75.74 Ext 75774     |
|                            | Fax: +34 96 387.75.79                 |
-------Address--------------------------------------------------------
|                 DISCA-EUI                                          |
|                 Universidad Politécnica de Valencia                |
|                 Campus de Vera #14                                 |
|                 Valencia E-46021                                   |
|                 Spain                                              |
----------------------------------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
