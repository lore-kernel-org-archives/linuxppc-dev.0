Return-Path: <SRS0=8rOk=ND=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB76C46475
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 16:52:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 846CC20665
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 16:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=infinera.com header.i=@infinera.com header.b="R7H1AHr+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 846CC20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=infinera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ffZR3WGCzF37M
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 03:52:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infinera.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=infinera.com header.i=@infinera.com header.b="R7H1AHr+";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=infinera.com
 (client-ip=104.47.37.69; helo=nam02-cy1-obe.outbound.protection.outlook.com;
 envelope-from=joakim.tjernlund@infinera.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=infinera.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=infinera.com header.i=@infinera.com header.b="R7H1AHr+";
 dkim-atps=neutral
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0069.outbound.protection.outlook.com [104.47.37.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ffWg25V7zF36q
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 03:50:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZW9Uib3Uh5YYI6yCpL0EOGI9Cira9fKnW3K5VOtZp8=;
 b=R7H1AHr+8+HO3Kvq9NjAA8zKBxcHUhq2aX9a5NfZ42nriT+03fjtxiK4+ceHQJ/Np+gH0Z2Ha3sKB4GiabaGODfsWbQYY2A4nFkRNL/FknHNd0pE4rcVzEmuP2RDF1YLEh/xYTwx3jaGFSsfP0F5iCYalHCB0D31dBbxyv9eE8k=
Received: from SN1PR10MB0736.namprd10.prod.outlook.com (10.163.206.15) by
 SN1PR10MB0495.namprd10.prod.outlook.com (10.162.103.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Tue, 23 Oct 2018 16:50:00 +0000
Received: from SN1PR10MB0736.namprd10.prod.outlook.com
 ([fe80::6855:de72:6814:7055]) by SN1PR10MB0736.namprd10.prod.outlook.com
 ([fe80::6855:de72:6814:7055%3]) with mapi id 15.20.1273.014; Tue, 23 Oct 2018
 16:50:00 +0000
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: ethernet "bus" number in DTS ?
Thread-Topic: ethernet "bus" number in DTS ?
Thread-Index: AQHUavBvzf0FONUzZkq6koorQ03jUQ==
Date: Tue, 23 Oct 2018 16:49:59 +0000
Message-ID: <88328977dfeaf667a98d791074b721fe730d285b.camel@infinera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Joakim.Tjernlund@infinera.com; 
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; SN1PR10MB0495;
 6:Z0AephR/sprMFLcAqgLDZ1SIgHMSlLfyICt6rxOeuLkxonNNm4qkmJAloooZdQ7L60kSNuARn3yWJXneG2EDsUqmUL/nqjkKz85cpcJEJdRbCescTzG4LLS9G5ifUrtJsckey5HNSgER08PHCeYrCcl/kGvu9Yn1XQMfsgdkDz0A+xlJI2Xtc9k4h0q0i4fTvCxZ92X4gB9mmZa255xi5tXQTl7XnppLe59Jmn+TjKxgqaOyCaRAe5QxuXSsAISRJUlb/r8Pbpe1pu49wxshDo+4HXcewodCI3pm7PoDXEMW7A+QJoNLEW6JtUNVU2FbnAUyWPVzINIqA8FnN8ev2vIZhBQFOZsy2QabXz/YX6plreTBrYULDqgVqRbm7aLvsZtKaxLh0Du6UuAHJ15O4AmIb1S21kjV9PTVhiJ2yfg3LDiiggmt0ViaZ0i1rwXhXPR5YCiMxxruIUWVGCiRKg==;
 5:5jwPRzeI8Yfg9kgtCT7+7X6lss0XmUWwb65tLq2G+szel+GeCgwkXJ1EpKNoUJD+/OPhgFbItglkJyDZT+byLnWRMJzBYEdnNHFckPvZsktLZ0KluN6PxXhaiPOUOPfkwRT+1dhlduInDj0MuIsy+4r/iZhJmLa39RyI4MN2cG4=;
 7:s+Pf+cR3I3T+DCNjKWp2fND1NzIEp2ghVLOJixuPFz6bY/BcCeUue+cchj6MHrFil9HOBGv8IyqN1h7E1/AGYcNkpgxsUpXQ/ItUH62aBASB1PgQ5Hra2UJAt9+24+jiziBCdu7mxgxE3a9/r6nKe97ztLkwiVkvMY+5keoTxVlrtnIRkCMJ6Qib+kwn4TtY0gGAqFSE8sM45q709XkHgWQd97cCouF2iPu82mVQYJ2T9TxyWVXyH5IpkU+2bZ8d
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 73232c61-208f-449a-1b7c-08d63907925b
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:SN1PR10MB0495; 
x-ms-traffictypediagnostic: SN1PR10MB0495:
x-microsoft-antispam-prvs: <SN1PR10MB049513E53CA0F1509213D504F4F50@SN1PR10MB0495.namprd10.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:SN1PR10MB0495; BCL:0; PCL:0; RULEID:; SRVR:SN1PR10MB0495; 
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(136003)(396003)(39860400002)(346002)(376002)(199004)(189003)(86362001)(99286004)(6486002)(68736007)(97736004)(486006)(5660300001)(2900100001)(2616005)(72206003)(7736002)(476003)(105586002)(2906002)(14454004)(5250100002)(2501003)(305945005)(25786009)(8936002)(53936002)(36756003)(3846002)(81156014)(81166006)(256004)(71200400001)(71190400001)(8676002)(554214002)(316002)(6506007)(26005)(186003)(6512007)(106356001)(110136005)(6116002)(118296001)(102836004)(66066001)(478600001)(6436002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR10MB0495;
 H:SN1PR10MB0736.namprd10.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: infinera.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sB3IKCePAeJG85UWl50FpAGPReXVWhFBydKcgBQCMVOCgK/VRXWS4jKGz1+gvfm9BgFB7RCE3qBlsH3RHAUwkp5wX1QTlqFKaDg7ZeLavBp6NmHjBHMGC7TQoOcW4KTHJcQqy7vUnaT+Hf9oy5Sljs/LW2vafEay+tNO3Sc7r03BMSZeAi8lQWMvMvGGMEZ7pAoA1KqjGazJ4I1a95yIYhohQnJEpeeZa/Z+iM7E9VDH2m74K4qpM7h2z56ma2j0ogIjBzKLE0dwJCYBbha7qE8DMIAFhUBoObb4HR+MImjjQkQvdvIPrLQpKe9/O9t/41jiM8HPtdo1ASAeZoCBRHgXJQl5T55bsil8oWFosEc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB569B4496DF7147A71F7618C7C973CD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73232c61-208f-449a-1b7c-08d63907925b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2018 16:50:00.1511 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR10MB0495
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

U1BJIChhbmQgb3RoZXJzKSBoYXMgYSB3YXkgdG8gZGVmaW5lIGJ1cyBudW1iZXIgaW4gYSBhbGlh
c2VzOg0KCWFsaWFzZXMgew0KCQlldGhlcm5ldDQgPSAmZW5ldDQ7DQoJCWV0aGVybmV0MCA9ICZl
bmV0MDsNCgkJZXRoZXJuZXQxID0gJmVuZXQxOw0KCQlldGhlcm5ldDIgPSAmZW5ldDI7DQoJCWV0
aGVybmV0MyA9ICZlbmV0MzsNCgkJc3BpMCA9ICZzcGkwDQoJfTsNClRoZSAwIGluIHRoZSBzcGkw
IGFsaWFzIHdpbGwgdHJhbnNsYXRlIHRvIGJ1cyBudW0gMCBzbyBvbmUgY2FuIGNvbnRyb2wgdGhl
IC9kZXYgbm9kZXMsIGxpa2UgL2Rldi9zcGlkZXYwDQpJIGFtIGxvb2tpbmcgZm9yIHRoZSBzYW1l
IGZvciBldGhlcm5ldCBkZXZpY2VzOg0KIGV0aGVybmV0NCA9ICZlbmV0NDsgIC8qIHNob3VsZCBi
ZWNvbWUgZXRoNCAqLw0KIGV0aGVybmV0MCA9ICZlbmV0MDsgIC8qIHNob3VsZCBiZWNvbWUgZXRo
MCAqLw0KYnV0IEkgY2Fubm90IGZpbmQgc29tZXRoaW5nIGxpa2UgdGhhdCBmb3IgZXRoIGRldmlj
ZXMuDQoNCkNvdWxkIHN1Y2ggZnVuY3Rpb25hbGl0eSBiZSBhZGRlZD8NCg0KIEpvY2tlDQo=
