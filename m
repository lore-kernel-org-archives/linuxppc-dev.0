Message-ID: <009e01c15006$c2bebaf0$7e7e7e7e@server>
From: "RSR - Piero Dominioni" <pdominioni@rsr.it>
To: "Jean-Denis Boyer" <jdboyer@mediatrix.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <F1BED55F35F4D3118C0F00E0295CFF4D414C30@mail.mediatrix.com>
Subject: R: NFS mount for TQM823L
Date: Mon, 8 Oct 2001 16:33:54 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0095_01C15017.05454460"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.

------=_NextPart_000_0095_01C15017.05454460
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

> > Try:
> >   ipconfig lo 127.0.0.1

> Well, of course, I meant 'ifconfig', not 'ipconfig'.
> I can't remember where this mistake comes from... ;-)

Dear Jean-Denis,
I think we're very close to the end, but not there yet!
I send you in attach the 'rpc' and 'services' files I loaded
on the target (I hand-wrote them first, unsuccessfully:
I copied then these ones from the host).
Here is what I type and obtain now.

/ # ifconfig lo 127.0.0.1
/ # /sbin/portmap
/ # rpcinfo -p
   program vers proto   port
    100000    2   tcp    111  portmapper
    100000    2   udp    111  portmapper
/ # /sbin/mountd
/ # /sbin/nfsd
/ # ps aux
  PID  Uid      Gid State Command
    1 root     root     S init
    2 root     root     S [keventd]
    3 root     root     S [kswapd]
    4 root     root     S [kreclaimd]
    5 root     root     S [bdflush]
    6 root     root     S [kupdated]
    9 root     root     R -sh
   12 root     root     S /sbin/inetd -i
   75 root     root     S /bin/sh /bin/application
   77 root     root     S sleep 500
   80 bin      root     S /sbin/portmap
   84 root     root     S [nfsd]
   85 root     root     S [lockd]
   86 root     root     S [rpciod]
   87 root     root     R ps aux
/ # rpcinfo -p
   program vers proto   port
    100000    2   tcp    111  portmapper
    100000    2   udp    111  portmapper
    100005    1   udp   2048  mountd
    100005    1   tcp   2048  mountd
    100005    2   udp   2048  mountd
    100005    2   tcp   2048  mountd
    100005    3   udp   2048  mountd
    100005    3   tcp   2048  mountd
    100003    2   udp   2049  nfs
    100003    3   udp   2049  nfs
    100021    1   udp   2048  nlockmgr
    100021    3   udp   2048  nlockmgr
    100021    4   udp   2048  nlockmgr

(Note that I type the 'mountd' command, but it doesn't
appear in the ps -aux output list!)
While if I type the same command for the host the
mountd uses a different port number...

/ # rpcinfo -p 126.126.126.106
   program vers proto   port
    100000    2   tcp    111  portmapper
    100000    2   udp    111  portmapper
    100005    1   udp    672  mountd
    100005    2   udp    672  mountd
    100005    1   tcp    675  mountd
    100005    2   tcp    675  mountd
    100003    2   udp   2049  nfs
    100003    2   tcp   2049  nfs
/ #

Your indications were once more correct: after to have
added the 'ifconfig' command to the target's busybox
(ver. 0.51) and to run it as you told me, 'rpcinfo -p' works fine.
But if I try to mount the target's filesystem from the host, with
/ # mount -t nfs 126.126.126.107:/  /mydir
on the host's console I get

mount: RPC: Program unavailable

while, exactly meantime, the following message appears
on the target's console:

svc: unknown program 100005 (me 100021)

I trust that your experience lets you understand
these messages better than me!
Waiting for your punctual answer...
Thank you.

Best regards.

Piero Dominioni
R.S.R. srl



------=_NextPart_000_0095_01C15017.05454460
Content-Type: application/octet-stream;
	name="services"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="services"

#=0A=
# Network services, Internet style=0A=
#=0A=
# Note that it is presently the policy of IANA to assign a single =
well-known=0A=
# port number for both TCP and UDP; hence, most entries here have two =
entries=0A=
# even if the protocol doesn't support UDP operations.=0A=
# Updated from RFC 1340, ``Assigned Numbers'' (July 1992).  Not all ports=0A=
# are included, only the more common ones.=0A=
#=0A=
#	from: @(#)services	5.8 (Berkeley) 5/9/91=0A=
#	$Id: services,v 1.9 1993/11/08 19:49:15 cgd Exp $=0A=
#=0A=
tcpmux		1/tcp		# TCP port service multiplexer=0A=
echo		7/tcp=0A=
echo		7/udp=0A=
discard		9/tcp		sink null=0A=
discard		9/udp		sink null=0A=
systat		11/tcp		users=0A=
daytime		13/tcp=0A=
daytime		13/udp=0A=
netstat		15/tcp=0A=
qotd		17/tcp		quote=0A=
msp		18/tcp		# message send protocol=0A=
msp		18/udp		# message send protocol=0A=
chargen		19/tcp		ttytst source=0A=
chargen		19/udp		ttytst source=0A=
ftp-data        20/tcp          # File Transfer [Default Data]=0A=
ftp-data        20/udp          # File Transfer [Default Data]=0A=
ftp             21/tcp          # File Transfer [Control]=0A=
ftp             21/udp          # File Transfer [Control]=0A=
ssh             22/tcp          # Secure Shell Login=0A=
ssh             22/udp          # Secure Shell Login=0A=
telnet          23/tcp=0A=
telnet          23/udp=0A=
# 24 - private=0A=
smtp		25/tcp		mail=0A=
# 26 - unassigned=0A=
time		37/tcp		timserver=0A=
time		37/udp		timserver=0A=
rlp		39/udp		resource	# resource location=0A=
nameserver	42/tcp		name		# IEN 116=0A=
whois		43/tcp		nicname=0A=
domain		53/tcp		nameserver	# name-domain server=0A=
domain		53/udp		nameserver=0A=
mtp		57/tcp				# deprecated=0A=
bootps		67/tcp		# BOOTP server=0A=
bootps		67/udp=0A=
bootpc		68/tcp		# BOOTP client=0A=
bootpc		68/udp=0A=
tftp		69/udp=0A=
gopher		70/tcp		# Internet Gopher=0A=
gopher		70/udp=0A=
rje		77/tcp		netrjs=0A=
finger		79/tcp=0A=
www		80/tcp		http	# WorldWideWeb HTTP=0A=
www		80/udp			# HyperText Transfer Protocol=0A=
link		87/tcp		ttylink=0A=
kerberos	88/tcp		krb5	# Kerberos v5=0A=
kerberos	88/udp=0A=
supdup		95/tcp=0A=
# 100 - reserved=0A=
hostnames	101/tcp		hostname	# usually from sri-nic=0A=
iso-tsap	102/tcp		tsap		# part of ISODE.=0A=
csnet-ns	105/tcp		cso-ns	# also used by CSO name server=0A=
csnet-ns	105/udp		cso-ns=0A=
rtelnet		107/tcp		# Remote Telnet=0A=
rtelnet		107/udp=0A=
pop2		109/tcp		postoffice	# POP version 2=0A=
pop2		109/udp=0A=
pop3		110/tcp		# POP version 3=0A=
pop3		110/udp=0A=
sunrpc		111/tcp=0A=
sunrpc		111/udp=0A=
auth		113/tcp		tap ident authentication=0A=
sftp		115/tcp=0A=
uucp-path	117/tcp=0A=
nntp		119/tcp		readnews untp	# USENET News Transfer Protocol=0A=
ntp		123/tcp=0A=
ntp		123/udp				# Network Time Protocol=0A=
netbios-ns	137/tcp				# NETBIOS Name Service=0A=
netbios-ns	137/udp=0A=
netbios-dgm	138/tcp				# NETBIOS Datagram Service=0A=
netbios-dgm	138/udp=0A=
netbios-ssn	139/tcp				# NETBIOS session service=0A=
netbios-ssn	139/udp=0A=
imap2		143/tcp				# Interim Mail Access Proto v2=0A=
imap2		143/udp=0A=
snmp		161/udp				# Simple Net Mgmt Proto=0A=
snmp-trap	162/udp		snmptrap	# Traps for SNMP=0A=
cmip-man	163/tcp				# ISO mgmt over IP (CMOT)=0A=
cmip-man	163/udp=0A=
cmip-agent	164/tcp=0A=
cmip-agent	164/udp=0A=
xdmcp		177/tcp				# X Display Mgr. Control Proto=0A=
xdmcp		177/udp=0A=
nextstep	178/tcp		NeXTStep NextStep	# NeXTStep window=0A=
nextstep	178/udp		NeXTStep NextStep	# server=0A=
bgp		179/tcp				# Border Gateway Proto.=0A=
bgp		179/udp=0A=
prospero	191/tcp				# Cliff Neuman's Prospero=0A=
prospero	191/udp=0A=
irc		194/tcp				# Internet Relay Chat=0A=
irc		194/udp=0A=
smux		199/tcp				# SNMP Unix Multiplexer=0A=
smux		199/udp=0A=
at-rtmp		201/tcp				# AppleTalk routing=0A=
at-rtmp		201/udp=0A=
at-nbp		202/tcp				# AppleTalk name binding=0A=
at-nbp		202/udp=0A=
at-echo		204/tcp				# AppleTalk echo=0A=
at-echo		204/udp=0A=
at-zis		206/tcp				# AppleTalk zone information=0A=
at-zis		206/udp=0A=
z3950		210/tcp		wais		# NISO Z39.50 database=0A=
z3950		210/udp		wais=0A=
ipx		213/tcp				# IPX=0A=
ipx		213/udp=0A=
imap3		220/tcp				# Interactive Mail Access=0A=
imap3		220/udp				# Protocol v3=0A=
ulistserv	372/tcp				# UNIX Listserv=0A=
ulistserv	372/udp=0A=
#=0A=
# UNIX specific services=0A=
#=0A=
exec		512/tcp=0A=
biff		512/udp		comsat=0A=
login		513/tcp=0A=
who		513/udp		whod=0A=
shell		514/tcp		cmd		# no passwords used=0A=
syslog		514/udp=0A=
printer		515/tcp		spooler		# line printer spooler=0A=
talk		517/udp=0A=
ntalk		518/udp=0A=
route		520/udp		router routed	# RIP=0A=
timed		525/udp		timeserver=0A=
tempo		526/tcp		newdate=0A=
courier		530/tcp		rpc=0A=
conference	531/tcp		chat=0A=
netnews		532/tcp		readnews=0A=
netwall		533/udp				# -for emergency broadcasts=0A=
uucp		540/tcp		uucpd		# uucp daemon=0A=
remotefs	556/tcp		rfs_server rfs	# Brunhoff remote filesystem=0A=
klogin		543/tcp				# Kerberized `rlogin' (v5)=0A=
kshell		544/tcp				# Kerberized `rsh' (v5)=0A=
kerberos-adm	749/tcp				# Kerberos `kadmin' (v5)=0A=
#=0A=
webster		765/tcp				# Network dictionary=0A=
webster		765/udp=0A=
#=0A=
# From ``Assigned Numbers'':=0A=
#=0A=
#> The Registered Ports are not controlled by the IANA and on most =
systems=0A=
#> can be used by ordinary user processes or programs executed by =
ordinary=0A=
#> users.=0A=
#=0A=
#> Ports are used in the TCP [45,106] to name the ends of logical=0A=
#> connections which carry long term conversations.  For the purpose of=0A=
#> providing services to unknown callers, a service contact port is=0A=
#> defined.  This list specifies the port used by the server process as =
its=0A=
#> contact port.  While the IANA can not control uses of these ports it=0A=
#> does register or list uses of these ports as a convienence to the=0A=
#> community.=0A=
#=0A=
ingreslock	1524/tcp=0A=
ingreslock	1524/udp=0A=
prospero-np	1525/tcp		# Prospero non-privileged=0A=
prospero-np	1525/udp=0A=
rfe		5002/tcp		# Radio Free Ethernet=0A=
rfe		5002/udp		# Actually uses UDP only=0A=
#=0A=
#=0A=
# Kerberos (Project Athena/MIT) services=0A=
# Note that these are for Kerberos v4, and are unofficial.  Sites running=0A=
# v4 should uncomment these and comment out the v5 entries above.=0A=
#=0A=
#kerberos	750/udp		kdc	# Kerberos (server) udp=0A=
#kerberos	750/tcp		kdc	# Kerberos (server) tcp=0A=
krbupdate	760/tcp		kreg	# Kerberos registration=0A=
kpasswd		761/tcp		kpwd	# Kerberos "passwd"=0A=
#klogin		543/tcp			# Kerberos rlogin=0A=
eklogin		2105/tcp		# Kerberos encrypted rlogin=0A=
#kshell		544/tcp		krcmd	# Kerberos remote shell=0A=
#=0A=
# Unofficial but necessary (for NetBSD) services=0A=
#=0A=
supfilesrv	871/tcp			# SUP server=0A=
supfiledbg	1127/tcp		# SUP debugging=0A=

------=_NextPart_000_0095_01C15017.05454460
Content-Type: application/octet-stream;
	name="rpc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="rpc"

#ident	"@(#)rpc	1.11	95/07/14 SMI"	/* SVr4.0 1.2	*/=0A=
#=0A=
#	rpc=0A=
#=0A=
portmapper	100000	portmap sunrpc rpcbind=0A=
rstatd		100001	rstat rup perfmeter rstat_svc=0A=
rusersd		100002	rusers=0A=
nfs		100003	nfsprog=0A=
ypserv		100004	ypprog=0A=
mountd		100005	mount showmount=0A=
ypbind		100007=0A=
walld		100008	rwall shutdown=0A=
yppasswdd	100009	yppasswd=0A=
etherstatd	100010	etherstat=0A=
rquotad		100011	rquotaprog quota rquota=0A=
sprayd		100012	spray=0A=
3270_mapper	100013=0A=
rje_mapper	100014=0A=
selection_svc	100015	selnsvc=0A=
database_svc	100016=0A=
rexd		100017	rex=0A=
alis		100018=0A=
sched		100019=0A=
llockmgr	100020=0A=
nlockmgr	100021=0A=
x25.inr		100022=0A=
statmon		100023=0A=
status		100024=0A=
bootparam	100026=0A=
ypupdated	100028	ypupdate=0A=
keyserv		100029	keyserver=0A=
sunlink_mapper	100033=0A=
tfsd		100037=0A=
nsed		100038=0A=
nsemntd		100039=0A=
showfhd		100043	showfh=0A=
ioadmd		100055	rpc.ioadmd=0A=
NETlicense	100062=0A=
sunisamd	100065=0A=
debug_svc 	100066  dbsrv=0A=
ypxfrd		100069  rpc.ypxfrd=0A=
bugtraqd	100071=0A=
kerbd		100078=0A=
event		100101	na.event	# SunNet Manager=0A=
logger		100102	na.logger	# SunNet Manager=0A=
sync		100104	na.sync=0A=
hostperf	100107	na.hostperf=0A=
activity	100109	na.activity	# SunNet Manager=0A=
hostmem		100112	na.hostmem=0A=
sample		100113	na.sample=0A=
x25		100114	na.x25=0A=
ping		100115	na.ping=0A=
rpcnfs		100116	na.rpcnfs=0A=
hostif		100117	na.hostif=0A=
etherif		100118	na.etherif=0A=
iproutes	100120	na.iproutes=0A=
layers		100121	na.layers=0A=
snmp		100122	na.snmp snmp-cmc snmp-synoptics snmp-unisys snmp-utk=0A=
traffic		100123	na.traffic=0A=
nfs_acl		100227=0A=
sadmind		100232=0A=
nisd		100300	rpc.nisd=0A=
nispasswd	100303	rpc.nispasswdd=0A=
ufsd		100233	ufsd=0A=
pcnfsd		150001	pcnfs=0A=
amd		300019  amq=0A=
bwnfsd		545580417=0A=
fypxfrd		600100069 freebsd-ypxfrd=0A=

------=_NextPart_000_0095_01C15017.05454460--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
