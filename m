Return-Path: <fenkes@de.ibm.com>
Received: from mtagate8.de.ibm.com (mtagate8.de.ibm.com [195.212.29.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C48F6DDED8
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Jul 2007 23:02:27 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate8.de.ibm.com (8.13.8/8.13.8) with ESMTP id l69D2NVc213178
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jul 2007 13:02:23 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l69D2NvX2072726
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jul 2007 15:02:23 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l69D2MPq016599
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jul 2007 15:02:23 +0200
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>
Subject: [PATCH 00/13] IB/ehca: eHCA2 enablement & some fixes
Date: Mon, 9 Jul 2007 15:02:21 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707091502.22407.fenkes@de.ibm.com>
Cc: Stefan Roscher <stefan.roscher@de.ibm.com>,
	Christoph Raisch <raisch@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch series enables the eHCA device driver to support new functions of
the eHCA2 chip. In addition, there are some bug fixes, code optimizations
and general new features included. Another set of patches will follow.

The patches, in detail, are:

[01/13] fixes a wrong parameter description
[02/13] adds HW capabilities autodetection
[03/13] restructures the QP code, preparing for Share Receive Queues (SRQ)
[04/13] adds SRQ support
[05/13] adds support for UD low latency QPs
[06/13] sets a flag that needs to be set on eHCA2
[07/13] adds RDMA atomic attributes to the data returned by query_qp()
[08/13] straightens out lock flag naming and adds static initializers
[09/13] refactors synchronization between completions and destroy_cq()
[10/13] changes the global idr spinlocks into rwlocks
[11/13] returns the QP pointer in poll_cq() instead of NULL
[12/13] adds notifications in case the SM LID etc. changes
[13/13] adds a slight latency improvement

The patches should apply cleanly, in order, against Roland's git. Please
review the changes and apply the patches for 2.6.23 if they are okay.

Regards,
  Joachim

=2D-=20
Joachim Fenkes =A0-- =A0eHCA Linux Driver Developer and Hardware Tamer
IBM Deutschland Entwicklung GmbH =A0-- =A0Dept. 3627 (I/O Firmware Dev. 2)
Schoenaicher Strasse 220 =A0-- =A071032 Boeblingen =A0-- =A0Germany
eMail: fenkes@de.ibm.com
