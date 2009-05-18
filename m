Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id EFEB4DE0C4
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 08:04:25 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1M6AwY-0001BN-IJ
	for linuxppc-dev@ozlabs.org; Mon, 18 May 2009 15:04:22 -0700
Message-ID: <23606187.post@talk.nabble.com>
Date: Mon, 18 May 2009 15:04:22 -0700 (PDT)
From: Jerome Walters <jeronimo@fixity.net>
To: linuxppc-dev@ozlabs.org
Subject: Re: [OT] Lite5200B w/ nfs root hangs after some time
In-Reply-To: <1240422181.5492.0@antares>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <1240422181.5492.0@antares>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


We experience exactly the same problem. Our client is Debian Testing
(_Squeeze_) x86 =E2=80=93 diskless node which uses nfsroot and boots from t=
he server
also Debian Testing (_Squeeze_) x86. While the client hang the server is
responding to everyone else's requests. Restarting the nfsd on the server
doesn't solve the problem.

At first I wasnt able to capture debug information on the client side since
/var/log was mounted over the nfs, so I have installed a hard drive where I
mounted only /var/log to be able to capture debug logs from the client as
well.


Debug Logs:=20
http://fixity.net/tmp/client.log.gz - Kernel RPC Debug Log from the client
http://fixity.net/tmp/server.log.gz - Kernel RPC Debug Log from the server


How reproducible:
Happens from 10 to 90 minutes after booting the diskless node.


Actual results:
NFS connections stop responding, system hangs or becomes very slow and
unresponsive (it doesnt respond to Ctrl+Alt+Del as well). 60 to 90 minutes
after the first server time out client says server OK but the client is
still
unresponsive. Immediately after that the client logs server connection loss
again which leads to continues loop. Client is still unresponsive. Sometime=
s
client resumes normal operation for couple of hours but then the problem
repeats.


Connectivity info:=20
Both the client and the server are connected to Gigabit Ethernet Cisco Metr=
o
series managable switch. Both of them use Intel Pro 82545GM Gigabit Etherne=
t
Server Controllers. Neither one of them log any Ethernet errors and none ar=
e
logged by the switch.


Client & Server Load:
For the purposes of testing both machines were only running needed daemons
and
weren't loaded at all.


Client & Server Kernel:
On both the client and server custom compiled linux 2.6.29.3 kernel was
used.
Configuration file @ http://fixity.net/tmp/config-2.6.29.3.gz


Client & Server Network interface fragmented packet queue length:
net.ipv4.ipfrag_high_thresh =3D 524288
net.ipv4.ipfrag_low_thresh =3D 393216


Client Versions:
libnfsidmap2/squeeze uptodate 0.21-2
nfs-common/squeeze uptodate 1:1.1.4-1


Client Mount (cat /proc/mounts | grep nfsroot):
10.11.11.1:/nfsroot / nfs
rw,vers=3D3,rsize=3D524288,wsize=3D524288,namlen=3D255,hard,nointr,nolock,p=
roto=3Dtcp,timeo=3D7,retrans=3D10,sec=3Dsys,addr=3D10.11.11.1
0 0


Client fstab:
proc            /proc           proc    defaults        0       0
/dev/nfs        /               nfs     defaults        1       1
none            /tmp            tmpfs   defaults        0       0
none            /var/run        tmpfs   defaults        0       0
none            /var/lock       tmpfs   defaults        0       0
none            /var/tmp        tmpfs   defaults        0       0


Client Daemons:
portmap, rpc.statd, rpc.idmapd


Server Daemons:
portmap, rpc.statd, rpc.idmapd, rpc.mountd --manage-gids


Server Versions:
libnfsidmap2/squeeze uptodate 0.21-2
nfs-common/squeeze uptodate 1:1.1.4-1
nfs-kernel-server/testing uptodate 1:1.1.4-1


Server Export:
/nfsroot 10.11.11.*(rw,no_root_squash,async,no_subtree_check)


Server Options:
RPCNFSDCOUNT=3D16
RPCNFSDPRIORITY=3D0
RPCMOUNTDOPTS=3D--manage-gids
NEED_SVCGSSD=3Dno
RPCSVCGSSDOPTS=3Dno


Additional Info:
Since I have read that tweaking the nfsroot mount options could improve the=
=20
situation a have tested with different options as follows:
rsize/wsize=3D1024|2048|4096|8192|32768|524288
timeo=3D7|15|60|600
retrans=3D3|10|20
None resulted in solving the problem.


I have also tested with the following version on the client and server end
without any difference in the behaviour:
libnfsidmap2/testing uptodate 0.21-2
nfs-common 1:1.1.6-1 newer than version in archive
nfs-kernel-server 1:1.1.6-1 newer than version in archive



Any help or suggestions on fixing the problem would be highly appreciated. =
I=20
have been messing with that problem for the last couple of weeks and ran ou=
t
of ideas.



Best Regards,
Jerome Walters =20
--=20
View this message in context: http://www.nabble.com/-OT--Lite5200B-w--nfs-r=
oot-hangs-after-some-time-tp23181953p23606187.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
